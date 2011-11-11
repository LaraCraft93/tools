#!/usr/bin/env python                                                         
# -*- encoding: utf-8 -*-                                                 
# Autor: {developer} - {mail} 
# Versão: {version} | Sob Licença GPL                                           |
#                                                                         |
# Comentários Adicionais:                                                 |
# As licenças de softwares foram desenvolvidas para restringir sua        |
# liberdade de compartilhá-lo e mudá-lo. Ao contrário dessas, a Licença   |
# Pública Geral GNU (GPL) garante a sua liberdade de compartilhar e       |
# alterar software livres, garantindo que o software será livre e         |
# gratuito para os seus usuários. Esta Licença Pública Geral aplica-se a  |
# maioria dos software da Free Software Foundation e a qualquer outro     |
# programa cujo autor decida aplicá-la.                                   |
# Quando nos referimos a software livre, estamos nos referindo a          |
# liberdade e não a preço. A Licença Pública Geral foi desenvolvida       |
# para garantir que você tenha a liberdade de distribuir cópias de        |
# software livre (e cobrar por isso, se quiser) e que você possa mudar o  |
# software ou utilizar partes dele em novos programas livres e            |
# gratuitos; e é importante que você saiba que pode fazer tudo isso.      |
#                                                                         |
# Viva o Source, Viva o Livre                                             |
# ----------------------------------------------------------------------- |
# Roadmap:                                                                |
# 1 - 

# ------------------------------------------------------------------------´

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import GLib, Gtk, Gdk, GdkPixbuf, Pango
import os, sys

### CONFIG ###
verbose=True
maintainer_mode=True
verbose_dump=False
sys.argv.pop(0)
##############

class JanelaPrincipal:
	def __init__(self):
		builder = Gtk.Builder()
		#builder.add_from_string('pui')
		builder.add_from_file('principal.xml')
		builder.connect_signals(self)
		
		self.janela = builder.get_object('JanelaPrincipal')

		self.verbose_gtk = builder.get_object('verbose_gtk')
		self.scroll_frame = builder.get_object('ScrollFrame')
		
		self.colorBlack = Gdk.Color(00000, 00000, 00000)
		self.colorWhite = Gdk.Color(65535, 65535, 65535)
		self.verbose_gtk.modify_bg(Gtk.StateType.NORMAL, self.colorBlack)
		self.verbose_gtk.modify_fg(Gtk.StateType.NORMAL, self.colorWhite)
		self.verbose_gtk_text = self.verbose_gtk.get_buffer()
		
		self.janela.show()
	
	def on_window_destroy(self, widget):
		Gtk.main_quit()

if __name__ == "__main__":
	if os.path.exists('C:\\Windows\\'):
		print "\n Este programa não foi feito para rodar em sua plataforma.\n\
 Use a versão para Windows, disponibilizada em http://forum.fretsonfire.net.br/forum\n"
		exit()
		
	try:
		for argumento in sys.argv:
			if argumento == "--verbose":
				verbose=True
			elif argumento == "--no-verbose":
				verbose=False
			elif argumento == "--maintainer-mode":
				maintainer_mode=True
			elif argumento == "--help":
				print "\nParâmetros disponíveis:\n\
		Ativar verbose:       ./script --verbose\n\
		Desativar verbose:    ./script --no-verbose\n\
		Ativar Modo de Teste: ./script --maintainer-mode\n\
		Exibir Ajuda:         ./script --help\n"
				exit()
			else:
				print "\nParâmetros incorretos. Tente --help\n"
				exit()
	except Exception as Ex:
		if str(Ex) == "list index out of range":
			pass
		else:
			print "Ocorreu um erro: "+str(Ex)
			exit()
	
	
	if maintainer_mode == True:
		title='\nATENÇÂO! Você está entrando no modo Maintainer!'
		msg='Esse é um modo especial criado para encontrar e corrigir \
bugs\nque possam vir a ocorrer. Você pode DANIFICAR SERIAMENTE\n\
seus arquivos se não souber o que está fazendo.\
\n\nNão me responsabilizo por nada neste modo de execução.\
\nSe entrou nesse modo por engano, clique em cancelar e \
execute\no programa pela forma convencional.'
		dialog=Gtk.MessageDialog(None, Gtk.DialogFlags.MODAL, Gtk.MessageType.WARNING, Gtk.ButtonsType.OK_CANCEL, title)
		dialog.format_secondary_text(msg)
		confirma = dialog.run()
		dialog.destroy()
		if confirma == Gtk.ResponseType.CANCEL:
			exit()
	
	if verbose == True:
		sys.stdout = sys.__stdout__
		print '\033[01;33m\n	### CONFIG ###\n\n\
	Verbose:    '+ str(verbose) +'\n\
	Maintainer: '+ str(maintainer_mode) +'\n\
	Argumentos: '+ str(sys.argv) +'\033[m\n'
	else:
		sys.stdout = open("/dev/null", 'a')
		
	app = JanelaPrincipal()
	Gtk.main()
