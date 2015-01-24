/*
 * Lara Maia <lara@craft.net.br> 2015
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <curl/curl.h>
#include <string.h>
#include <unistd.h>

int check(char *url) {
    CURL *session = curl_easy_init();
    FILE *devnull = fopen("/dev/null", "w+");
    char *status = "Offline";
    
    curl_easy_setopt(session, CURLOPT_URL, url);
    curl_easy_setopt(session, CURLOPT_WRITEDATA, devnull);
    curl_easy_setopt(session, CURLOPT_TIMEOUT_MS, 900);
    curl_easy_setopt(session, CURLOPT_CONNECTTIMEOUT_MS, 300);

    CURLcode data = curl_easy_perform(session);
    if(data == CURLE_OK)
        status = "Online ";
    
    printf(status);
    
    curl_easy_cleanup(session);
    fclose(devnull);
    return 0;
}

int get_bytes(char *dev, char *type) {
    char stat_file[44];
    char buffer[12];
    FILE *bytes_file;
    
    sprintf(stat_file, "/sys/class/net/%s/statistics/%s_bytes", dev, type);
    bytes_file = fopen(stat_file, "r");
    fgets(buffer, 11, bytes_file);
    fclose(bytes_file);
    
    return atoi(buffer);
}

int speed(char *dev, char *type, int max) {
    int first, end, perc;

    first = get_bytes(dev, type);
    sleep(1);
    end = get_bytes(dev, type);

    perc=((end - first) * 100) / max;
    if(perc > 100) perc=100;

    printf("%d\n", perc);
    return 0;
}

int main(int argc, char **argv) {
    if(!strcmp(argv[1], "check")) {
        check(argv[2]);
    } else if(!strcmp(argv[1], "speed")) {
        speed(argv[2], argv[3], atoi(argv[4]));
    }
    
    return 0;
}
