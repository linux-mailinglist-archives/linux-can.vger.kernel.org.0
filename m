Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2F3BE21
	for <lists+linux-can@lfdr.de>; Mon, 10 Jun 2019 23:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbfFJVKM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jun 2019 17:10:12 -0400
Received: from enpas.org ([46.38.239.100]:49918 "EHLO mail.enpas.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfFJVKM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 10 Jun 2019 17:10:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id D873C1002D7;
        Mon, 10 Jun 2019 21:01:31 +0000 (UTC)
From:   Max Staudt <max-linux@enpas.org>
To:     linux-can@vger.kernel.org
Cc:     max-linux@enpas.org, oneukum@suse.com
Subject: [RFC net] can: elmcan driver for ELM327 based OBD-II adapters
Date:   Mon, 10 Jun 2019 23:01:02 +0200
Message-Id: <20190610210102.10599-1-max-linux@enpas.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is the elmcan driver. It does a surprisingly good job at turning
ELM327 based OBD-II interfaces into cheap CAN interfaces for simple
homebrew projects.

Please see the included documentation for details and limitations:
Documentation/networking/device_drivers/elmcan.rst

Big thanks go out to Oliver Neukum for his reviews, wisdom, and
encouragement while writing this.

Cc: linux-can <linux-can@vger.kernel.org>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Max Staudt <max-linux@enpas.org>
---
 Documentation/networking/device_drivers/elmcan.rst |  348 ++++++
 drivers/net/can/Kconfig                            |   17 +
 drivers/net/can/Makefile                           |    1 +
 drivers/net/can/elmcan.c                           | 1262 ++++++++++++++++++++
 include/uapi/linux/tty.h                           |    1 +
 5 files changed, 1629 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/elmcan.rst
 create mode 100644 drivers/net/can/elmcan.c

diff --git a/Documentation/networking/device_drivers/elmcan.rst b/Documentation/networking/device_drivers/elmcan.rst
new file mode 100644
index 000000000..2898e0452
--- /dev/null
+++ b/Documentation/networking/device_drivers/elmcan.rst
@@ -0,0 +1,348 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Linux SocketCAN driver for ELM327
+==================================
+
+Authors
+--------
+
+Max Staudt <max-linux@enpas.org>
+
+
+
+Motivation
+-----------
+
+This driver aims to lower the initial cost for hackers interested in
+working with CAN buses.
+
+CAN adapters are expensive, few, and far between.
+ELM327 interfaces are cheap and plentiful.
+Let's use ELM327s as CAN adapters.
+
+
+
+Introduction
+-------------
+
+This driver is an effort to turn abundant ELM327 based OBD interfaces
+into full-fledged (as far as possible) CAN interfaces.
+
+Since the ELM327 was never meant to be a stand-alone CAN controller,
+the driver has to switch between its modes as quickly as possible in
+order to fake full-duplex operation.
+
+As such, elmcan is a best-effort driver. However, this is more than
+enough to implement simple request-response protocols (such as OBD II),
+and to monitor broadcast messages on a bus (such as in a vehicle).
+
+Most ELM327s come as nondescript serial devices, attached via USB or
+Bluetooth. The driver cannot recognize them by itself, and as such it
+is up to the user to attach it in form of a TTY line discipline
+(similar to PPP, SLIP, slcan, ...).
+
+This driver is meant for ELM327 versions 1.4b and up, see below for
+known limitations in older controllers and clones.
+
+
+
+Requirements
+-------------
+
+This requires Linux 4.11 (for 431af779256c), and has been tested on 4.19.
+
+Also, elmcan depends on ``can-dev``:
+
+    sudo modprobe can-dev
+
+
+
+Data sheet
+-----------
+
+The official data sheets can be found at ELM electronics' home page:
+
+  https://www.elmelectronics.com/
+
+
+
+How to check the controller version
+------------------------------------
+
+Use a terminal program to attach to the controller.
+The default settings are 38400 baud/s, 8 data bits, no parity, 1 stopbit.
+
+After issuing the "``AT WS``" command, the controller will respond with
+its version::
+
+    >AT WS
+
+
+    ELM327 v1.4b
+
+    >
+
+Note that clones may claim to be any version they like.
+It is not indicative of their actual feature set.
+
+
+
+How to attach the line discipline
+----------------------------------
+
+Every ELM327 chip is factory programmed to operate at a serial setting
+of 38400 baud/s, 8 data bits, no parity, 1 stopbit.
+
+The line discipline can be attached on a command prompt as follows::
+
+    sudo ldattach \
+           --debug \
+           --speed 38400 \
+           --eightbits \
+           --noparity \
+           --onestopbit \
+           --iflag -ICRNL,INLCR,-IXOFF \
+           28 \
+           /dev/ttyUSB0
+
+To change the ELM327's serial settings, please refer to its data
+sheet. This needs to be done before attaching the line discipline.
+
+
+
+Module parameters
+------------------
+
+- ``accept_flaky_uart`` - Try to live with a bad controller or UART line
+
+	Some adapters and/or their connection are unreliable. Enable this
+	option to try and work around the situation. This is a best-effort
+	workaround, so undefined behavior will likely occur sooner or later.
+	Without this option, the driver will bail on the first unrecognized
+	character it receives from the TTY.
+
+	LOAD TIME::
+
+		module/kernel parameter: accept_flaky_uart=[0|1]
+
+
+
+Known limitations of the controller
+------------------------------------
+
+- Clone devices ("v1.5" and others)
+
+  Sending RTR frames is not supported and will be dropped silently.
+
+  Receiving RTR with DLC 8 will appear to be a regular frame with
+  the last received frame's DLC and payload.
+
+  "``AT CSM``" not supported, thus no ACK-ing frames while listening:
+  "``AT MA``" will always be silent. However, immediately after
+  sending a frame, the ELM327 will be in "receive reply" mode, in
+  which it *does* ACK any received frames. Once the bus goes silent
+  or an error occurs (such as BUFFER FULL), the ELM327 will end reply
+  reception mode on its own and elmcan will fall back to "``AT MA``"
+  in order to keep monitoring the bus.
+
+
+- All versions
+
+  No full duplex operation is supported. The driver will switch
+  between input/output mode as quickly as possible.
+
+  The length of outgoing RTR frames cannot be set. In fact, some
+  clones (tested with one identifying as "``v1.5``") are unable to
+  send RTR frames at all.
+
+  We don't have a way to get real-time notifications on CAN errors.
+  While there is a command (``AT CS``) to retrieve some basic stats,
+  we don't poll it as it would force us to interrupt reception mode.
+
+
+- Versions prior to 1.4b
+
+  These versions do not send CAN ACKs when in monitoring mode (AT MA).
+  However, they do send ACKs while waiting for a reply immediately
+  after sending a frame. The driver maximizes this time to make the
+  controller as useful as possible.
+
+  Starting with version 1.4b, the ELM327 supports the "``AT CSM``"
+  command, and the "listen-only" CAN option will take effect.
+
+
+- Versions prior to 1.4
+
+  These chips do not support the "``AT PB``" command, and thus cannot
+  change bitrate or SFF/EFF mode on-the-fly. This will have to be
+  programmed by the user before attaching the line discipline. See the
+  data sheet for details.
+
+
+- Versions prior to 1.3
+
+  These chips cannot be used at all with elmcan. They do not support
+  the "``AT D1``", which is necessary to avoid parsing conflicts on
+  incoming data, as well as distinction of RTR frame lengths.
+
+  Specifically, this allows for easy distinction of SFF and EFF
+  frames, and to check whether frames are complete. While it is possible
+  to deduce the type and length from the length of the line the ELM327
+  sends us, this method fails when the ELM327's UART output buffer
+  overruns. It may abort sending in the middle of the line, which will
+  then be mistaken for something else.
+
+
+
+Known limitations of the driver
+--------------------------------
+
+- No 8/7 timing.
+
+  ELM327 can only set CAN bitrates that are of the form 500000/n, where
+  n is an integer divisor.
+  However there is an exception: With a separate flag, it may set the
+  speed to be 8/7 of the speed indicated by the divisor.
+  This mode is not currently implemented.
+
+- No evaluation of command responses.
+
+  The ELM327 will reply with OK when a command is understood, and with ?
+  when it is not. The driver does not currently check this, and simply
+  assumes that the chip understands every command.
+  The driver is built such that functionality degrades gracefully
+  nevertheless. See the section on known limitations of the controller.
+
+- No use of hardware CAN ID filtering
+
+  An ELM327's UART sending buffer will easily overflow on heavy CAN bus
+  load, resulting in the "``BUFFER FULL``" message. Using the hardware
+  filters available through "``AT CF xxx``" and "``AT CM xxx``" would be
+  helpful here, however SocketCAN does not currently provide a facility
+  to make use of such hardware features.
+
+
+
+Communication example
+----------------------
+
+This is a short and incomplete introduction on how to talk to an ELM327.
+
+
+The ELM327 has two modes:
+
+- Command mode
+- Reception mode
+
+In command mode, it expects one command per line, terminated by CR.
+By default, the prompt is a "``>``", after which a command can be
+entered::
+
+    >ATE1
+    OK
+    >
+
+The init script in the driver switches off several configuration options
+that are only meaningful in the original OBD scenario the chip is meant
+for, and are actually a hindrance for elmcan.
+
+
+When a command is not recognized, such as by an older version of the
+ELM327, a question mark is printed as a response instead of OK::
+
+    >ATUNKNOWN
+    ?
+    >
+
+At present, elmcan does not evaluate this response and silently assumes
+that all commands are recognized. It is structured such that it will
+degrade gracefully when a command is unknown. See the sections above on
+known limitations for details.
+
+
+When a CAN frame is to be sent, the target address is configured, after
+which the frame is sent as a command that consists of the data's hex
+dump::
+
+    >ATSH123
+    OK
+    >DEADBEEF12345678
+    OK
+    >
+
+The above interaction sends the frame "``DE AD BE EF 12 34 56 78``" with
+the 11 bit CAN ID ``0x123``.
+For this to function, the controller must be configured for 11 bit CAN
+ID sending mode (using "``AT PB``", see code or datasheet).
+
+
+Once a frame has been sent and wait-for-reply mode is on (``ATR1``,
+configured on ``listen-only=off``), or when the reply timeout expires and
+the driver sets the controller into monitoring mode (``ATMA``), the ELM327
+will send one line for each received CAN frame, consisting of CAN ID,
+DLC, and data::
+
+    123 8 DEADBEEF12345678
+
+For 29 bit CAN frames, the address format is slightly different, which
+elmcan uses to tell the two apart::
+
+    12 34 56 78 8 DEADBEEF12345678
+
+The ELM327 will receive both 11 and 29 bit frames - the current CAN
+config (``ATPB``) does not matter.
+
+
+If the ELM327's internal UART sending buffer runs full, it will abort
+the monitoring mode, print "BUFFER FULL" and drop back into command
+mode. Note that in this case, unlike with other error messages, the
+error message may appear on the same line as the last (usually
+incomplete) data frame::
+
+    12 34 56 78 8 DEADBEEF123 BUFFER FULL
+
+
+
+Rationale behind the chosen configuration
+------------------------------------------
+
+``AT E1``
+  Echo on
+
+  We need this to be able to get a prompt reliably.
+
+``AT S1``
+  Spaces on
+
+  We need this to distinguish 11/29 bit CAN addresses received.
+
+  Note:
+  We can usually do this using the line length (odd/even),
+  but this fails if the line is not transmitted fully to
+  the host (BUFFER FULL).
+
+``AT D1``
+  DLC on
+
+  We need this to tell the "length" of RTR frames.
+
+
+
+A note on CAN bus termination
+------------------------------
+
+Your adapter may have resistors soldered in which are meant to terminate
+the bus. This is correct when it is plugged into a OBD-II socket, but
+not helpful when trying to tap into the middle of an existing CAN bus.
+
+If communications don't work with the adapter connected, check for the
+termination resistors on its PCB and try removing them.
+
+
+
+Thanks
+-------
+
+Thanks go out to Oliver Neukum for his early reviews and suggestions.
+
+Several more people have encouraged me to finish this - thank you all.
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index ab585900a..07794f86c 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -48,6 +48,23 @@ config CAN_SLCAN
 	  can be changed by the 'maxdev=xx' module option. This driver can
 	  also be built as a module. If so, the module will be called slcan.
 
+config CAN_ELMCAN
+	tristate "Serial / USB serial ELM327 based OBD-II Interfaces (elmcan)"
+	depends on TTY
+	help
+	  CAN driver for several 'low cost' OBD-II interfaces based on the
+	  ELM327 OBD-II interpreter chip.
+
+	  This is a best-effort driver - the ELM327 interface was never designed
+	  to be used as a stand-alone CAN interface. However, this is sufficient
+	  to implement simple request-response protocols (such as OBD II), and
+	  to monitor broadcast messages on a bus (such as in a vehicle).
+
+	  Please refer to the documentation for information on how to use it:
+	  Documentation/networking/device_drivers/elmcan.rst
+
+	  If this driver is built as a module, it will be called elmcan.
+
 config CAN_DEV
 	tristate "Platform CAN drivers with Netlink support"
 	default y
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 44922bf29..d6785933e 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
 obj-$(CONFIG_CAN_SLCAN)		+= slcan.o
+obj-$(CONFIG_CAN_ELMCAN)	+= elmcan.o
 
 obj-$(CONFIG_CAN_DEV)		+= can-dev.o
 can-dev-y			+= dev.o
diff --git a/drivers/net/can/elmcan.c b/drivers/net/can/elmcan.c
new file mode 100644
index 000000000..d4cc7d568
--- /dev/null
+++ b/drivers/net/can/elmcan.c
@@ -0,0 +1,1262 @@
+// SPDX-License-Identifier: GPL-2.0
+/* elmcan.c - ELM327 based CAN interface driver
+ *            (tty line discipline)
+ *
+ * This file is derived from linux/drivers/net/can/slcan.c
+ *
+ * elmcan.c Author : Max Staudt <max-linux@enpas.org>
+ * slcan.c Author  : Oliver Hartkopp <socketcan@hartkopp.net>
+ * slip.c Authors  : Laurence Culhane <loz@holmes.demon.co.uk>
+ *                   Fred N. van Kempen <waltje@uwalt.nl.mugnet.org>
+ *
+ */
+
+#define pr_fmt(fmt) "[elmcan] " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/if_ether.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/tty.h>
+#include <linux/workqueue.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+#include <linux/can/led.h>
+
+MODULE_ALIAS_LDISC(N_ELMCAN);
+MODULE_DESCRIPTION("ELM327 based CAN interface");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Max Staudt <max-linux@enpas.org>");
+
+/* If this is enabled, we'll try to make the best of the situation
+ * even if we receive unexpected characters on the line.
+ * No guarantees.
+ * Handle with care, it's likely your hardware is unreliable!
+ */
+static bool accept_flaky_uart;
+module_param_named(accept_flaky_uart, accept_flaky_uart, bool, 0444);
+MODULE_PARM_DESC(accept_flaky_uart, "Don't bail at the first invalid character. Behavior undefined.");
+
+#define ELM327_SIZE_RXBUF 256
+#define ELM327_SIZE_TXBUF 32
+
+#define ELM327_CAN_CONFIG_SEND_SFF           0x8000
+#define ELM327_CAN_CONFIG_VARIABLE_DLC       0x4000
+#define ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF  0x2000
+#define ELM327_CAN_CONFIG_BAUDRATE_MULT_8_7  0x1000
+
+#define ELM327_MAGIC_CHAR 'y'
+#define ELM327_MAGIC_STRING "y"
+#define ELM327_READY_CHAR '>'
+
+/* Bits in elm->cmds_todo */
+enum ELM_TODO {
+	TODO_CAN_DATA = 0,
+	TODO_CANID_11BIT,
+	TODO_CANID_29BIT_LOW,
+	TODO_CANID_29BIT_HIGH,
+	TODO_CAN_CONFIG_PART2,
+	TODO_CAN_CONFIG,
+	TODO_RESPONSES,
+	TODO_SILENT_MONITOR,
+	TODO_INIT
+};
+
+struct elmcan {
+	/* This must be the first member when using alloc_candev() */
+	struct can_priv can;
+
+	/* TTY and netdev devices that we're bridging */
+	struct tty_struct	*tty;
+	struct net_device	*dev;
+
+	/* Per-channel lock */
+	spinlock_t		lock;
+
+	/* Keep track of how many things are using this struct.
+	 * Once it reaches 0, we are in the process of cleaning up,
+	 * and new operations will be cancelled immediately.
+	 * Use atomic_t rather than refcount_t because we deliberately
+	 * decrement to 0, and refcount_dec() spills a WARN_ONCE in
+	 * that case.
+	 */
+	atomic_t		refcount;
+
+	/* Stop the channel on hardware failure.
+	 * Once this is true, nothing will be sent to the TTY.
+	 */
+	bool			hw_failure;
+
+	/* TTY TX helpers */
+	struct work_struct	tx_work;	/* Flushes TTY TX buffer   */
+	unsigned char		*txbuf;
+	unsigned char		*txhead;	/* Pointer to next TX byte */
+	int			txleft;		/* Bytes left to TX */
+
+	/* TTY RX helpers */
+	unsigned char rxbuf[ELM327_SIZE_RXBUF];
+	int rxfill;
+
+	/* State machine */
+	enum {
+		ELM_NOTINIT = 0,
+		ELM_GETMAGICCHAR,
+		ELM_GETPROMPT,
+		ELM_RECEIVING,
+	} state;
+
+	int drop_next_line;
+
+	/* The CAN frame and config the ELM327 is sending/using,
+	 * or will send/use after finishing all cmds_todo
+	 */
+	struct can_frame can_frame;
+	unsigned short can_config;
+	unsigned long can_bitrate;
+	unsigned char can_bitrate_divisor;
+	int silent_monitoring;
+
+	/* Things we have yet to send */
+	char **next_init_cmd;
+	unsigned long cmds_todo;
+};
+
+/* A lock for all tty->disc_data handled by this ldisc.
+ * This is to prevent a case where tty->disc_data is set to NULL,
+ * yet someone is still trying to dereference it.
+ * Without this, we cannot do a clean shutdown.
+ */
+static DEFINE_SPINLOCK(elmcan_discdata_lock);
+
+static inline void elm327_hw_failure(struct elmcan *elm);
+
+ /***********************************************************************
+  *		ELM327: Transmission					*
+  *									*
+  * (all functions assume elm->lock taken)				*
+  ***********************************************************************/
+
+static void elm327_send(struct elmcan *elm, const void *buf, size_t len)
+{
+	int actual;
+
+	if (elm->hw_failure)
+		return;
+
+	memcpy(elm->txbuf, buf, len);
+
+	/* Order of next two lines is *very* important.
+	 * When we are sending a little amount of data,
+	 * the transfer may be completed inside the ops->write()
+	 * routine, because it's running with interrupts enabled.
+	 * In this case we *never* got WRITE_WAKEUP event,
+	 * if we did not request it before write operation.
+	 *       14 Oct 1994  Dmitry Gorodchanin.
+	 */
+	set_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
+	actual = elm->tty->ops->write(elm->tty, elm->txbuf, len);
+	if (actual < 0) {
+		netdev_err(elm->dev,
+			   "Failed to write to tty %s.\n",
+			   elm->tty->name);
+		elm327_hw_failure(elm);
+		return;
+	}
+
+	elm->txleft = len - actual;
+	elm->txhead = elm->txbuf + actual;
+}
+
+/* Take the ELM327 out of almost any state and back into command mode.
+ * We send ELM327_MAGIC_CHAR which will either abort any running
+ * operation, or be echoed back to us in case we're already in command
+ * mode.
+ */
+static void elm327_kick_into_cmd_mode(struct elmcan *elm)
+{
+	if (elm->state != ELM_GETMAGICCHAR && elm->state != ELM_GETPROMPT) {
+		elm327_send(elm, ELM327_MAGIC_STRING, 1);
+
+		elm->state = ELM_GETMAGICCHAR;
+	}
+}
+
+/* Schedule a CAN frame and necessary config changes to be sent to the TTY. */
+static void elm327_send_frame(struct elmcan *elm, struct can_frame *frame)
+{
+	/* Schedule any necessary changes in ELM327's CAN configuration */
+	if (elm->can_frame.can_id != frame->can_id) {
+		/* Set the new CAN ID for transmission. */
+		if ((frame->can_id & CAN_EFF_FLAG)
+		    ^ (elm->can_frame.can_id & CAN_EFF_FLAG)) {
+			elm->can_config = (frame->can_id & CAN_EFF_FLAG
+						? 0
+						: ELM327_CAN_CONFIG_SEND_SFF)
+					| ELM327_CAN_CONFIG_VARIABLE_DLC
+					| ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF
+					| elm->can_bitrate_divisor;
+
+			set_bit(TODO_CAN_CONFIG, &elm->cmds_todo);
+		}
+
+		if (frame->can_id & CAN_EFF_FLAG) {
+			clear_bit(TODO_CANID_11BIT, &elm->cmds_todo);
+			set_bit(TODO_CANID_29BIT_LOW, &elm->cmds_todo);
+			set_bit(TODO_CANID_29BIT_HIGH, &elm->cmds_todo);
+		} else {
+			set_bit(TODO_CANID_11BIT, &elm->cmds_todo);
+			clear_bit(TODO_CANID_29BIT_LOW, &elm->cmds_todo);
+			clear_bit(TODO_CANID_29BIT_HIGH, &elm->cmds_todo);
+		}
+	}
+
+	/* Schedule the CAN frame itself. */
+	elm->can_frame = *frame;
+	set_bit(TODO_CAN_DATA, &elm->cmds_todo);
+
+	elm327_kick_into_cmd_mode(elm);
+}
+
+ /***********************************************************************
+  *		ELM327: Initialization sequence				*
+  *									*
+  * (assumes elm->lock taken)						*
+  ***********************************************************************/
+
+static char *elm327_init_script[] = {
+	"AT WS\r",        /* v1.0: Warm Start */
+	"AT PP FF OFF\r", /* v1.0: All Programmable Parameters Off */
+	"AT M0\r",        /* v1.0: Memory Off */
+	"AT AL\r",        /* v1.0: Allow Long messages */
+	"AT BI\r",        /* v1.0: Bypass Initialization */
+	"AT CAF0\r",      /* v1.0: CAN Auto Formatting Off */
+	"AT CFC0\r",      /* v1.0: CAN Flow Control Off */
+	"AT CF 000\r",    /* v1.0: Reset CAN ID Filter */
+	"AT CM 000\r",    /* v1.0: Reset CAN ID Mask */
+	"AT E1\r",        /* v1.0: Echo On */
+	"AT H1\r",        /* v1.0: Headers On */
+	"AT L0\r",        /* v1.0: Linefeeds Off */
+	"AT SH 7DF\r",    /* v1.0: Set CAN sending ID to 0x7df */
+	"AT ST FF\r",     /* v1.0: Set maximum Timeout for response after TX */
+	"AT AT0\r",       /* v1.2: Adaptive Timing Off */
+	"AT D1\r",        /* v1.3: Print DLC On */
+	"AT S1\r",        /* v1.3: Spaces On */
+	"AT TP B\r",      /* v1.0: Try Protocol B */
+	NULL
+};
+
+static void elm327_init(struct elmcan *elm)
+{
+	elm->state = ELM_NOTINIT;
+	elm->can_frame.can_id = 0x7df;
+	elm->rxfill = 0;
+	elm->drop_next_line = 0;
+
+	/* We can only set the bitrate as a fraction of 500000.
+	 * The bit timing constants in elmcan_bittiming_const will
+	 * limit the user to the right values.
+	 */
+	elm->can_bitrate_divisor = 500000 / elm->can.bittiming.bitrate;
+	elm->can_config = ELM327_CAN_CONFIG_SEND_SFF
+			| ELM327_CAN_CONFIG_VARIABLE_DLC
+			| ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF
+			| elm->can_bitrate_divisor;
+
+	/* Configure ELM327 and then start monitoring */
+	elm->next_init_cmd = &elm327_init_script[0];
+	set_bit(TODO_INIT, &elm->cmds_todo);
+	set_bit(TODO_SILENT_MONITOR, &elm->cmds_todo);
+	set_bit(TODO_RESPONSES, &elm->cmds_todo);
+	set_bit(TODO_CAN_CONFIG, &elm->cmds_todo);
+
+	elm327_kick_into_cmd_mode(elm);
+}
+
+ /***********************************************************************
+  *		ELM327: Reception -> netdev glue			*
+  *									*
+  * (assumes elm->lock taken)						*
+  ***********************************************************************/
+
+static void elm327_feed_frame_to_netdev(struct elmcan *elm,
+					const struct can_frame *frame)
+{
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	if (!netif_running(elm->dev))
+		return;
+
+	skb = alloc_can_skb(elm->dev, &cf);
+
+	if (!skb)
+		return;
+
+	memcpy(cf, frame, sizeof(struct can_frame));
+
+	elm->dev->stats.rx_packets++;
+	elm->dev->stats.rx_bytes += frame->can_dlc;
+	netif_rx_ni(skb);
+
+	can_led_event(elm->dev, CAN_LED_EVENT_RX);
+}
+
+ /***********************************************************************
+  *		ELM327: "Panic" handler					*
+  *									*
+  * (assumes elm->lock taken)						*
+  ***********************************************************************/
+
+/* Called when we're out of ideas and just want it all to end. */
+static inline void elm327_hw_failure(struct elmcan *elm)
+{
+	struct can_frame frame;
+
+	memset(&frame, 0, sizeof(frame));
+	frame.can_id = CAN_ERR_FLAG;
+	frame.can_dlc = CAN_ERR_DLC;
+	frame.data[5] = 'R';
+	frame.data[6] = 'I';
+	frame.data[7] = 'P';
+	elm327_feed_frame_to_netdev(elm, &frame);
+
+	netdev_err(elm->dev, "ELM327 misbehaved. Blocking further communication.\n");
+
+	elm->hw_failure = true;
+	can_bus_off(elm->dev);
+}
+
+ /***********************************************************************
+  *		ELM327: Reception parser				*
+  *									*
+  * (assumes elm->lock taken)						*
+  ***********************************************************************/
+
+static void elm327_parse_error(struct elmcan *elm, int len)
+{
+	struct can_frame frame;
+
+	memset(&frame, 0, sizeof(frame));
+	frame.can_id = CAN_ERR_FLAG;
+	frame.can_dlc = CAN_ERR_DLC;
+
+	switch (len) {
+	case 17:
+		if (!memcmp(elm->rxbuf, "UNABLE TO CONNECT", 17)) {
+			netdev_err(elm->dev,
+				   "The ELM327 reported UNABLE TO CONNECT. Please check your setup.\n");
+		}
+		break;
+	case 11:
+		if (!memcmp(elm->rxbuf, "BUFFER FULL", 11)) {
+			/* This case will only happen if the last data
+			 * line was complete.
+			 * Otherwise, elm327_parse_frame() will heuristically
+			 * emit this error frame instead.
+			 */
+			frame.can_id |= CAN_ERR_CRTL;
+			frame.data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		}
+		break;
+	case 9:
+		if (!memcmp(elm->rxbuf, "BUS ERROR", 9))
+			frame.can_id |= CAN_ERR_BUSERROR;
+		if (!memcmp(elm->rxbuf, "CAN ERROR", 9))
+			frame.can_id |= CAN_ERR_PROT;
+		if (!memcmp(elm->rxbuf, "<RX ERROR", 9))
+			frame.can_id |= CAN_ERR_PROT;
+		break;
+	case 8:
+		if (!memcmp(elm->rxbuf, "BUS BUSY", 8)) {
+			frame.can_id |= CAN_ERR_PROT;
+			frame.data[2] = CAN_ERR_PROT_OVERLOAD;
+		}
+		if (!memcmp(elm->rxbuf, "FB ERROR", 8)) {
+			frame.can_id |= CAN_ERR_PROT;
+			frame.data[2] = CAN_ERR_PROT_TX;
+		}
+		break;
+	case 5:
+		if (!memcmp(elm->rxbuf, "ERR", 3)) {
+			netdev_err(elm->dev, "The ELM327 reported an ERR%c%c. Please power it off and on again.\n",
+				   elm->rxbuf[3], elm->rxbuf[4]);
+			frame.can_id |= CAN_ERR_CRTL;
+		}
+		break;
+	default:
+		/* Don't emit an error frame if we're unsure */
+		return;
+	}
+
+	elm327_feed_frame_to_netdev(elm, &frame);
+}
+
+/* Parse CAN frames coming as ASCII from ELM327.
+ * They can be of various formats:
+ *
+ * 29-bit ID (EFF):  12 34 56 78 D PL PL PL PL PL PL PL PL
+ * 11-bit ID (!EFF): 123 D PL PL PL PL PL PL PL PL
+ *
+ * where D = DLC, PL = payload byte
+ *
+ * Instead of a payload, RTR indicates a remote request.
+ *
+ * We will use the spaces and line length to guess the format.
+ */
+static int elm327_parse_frame(struct elmcan *elm, int len)
+{
+	struct can_frame frame;
+	int hexlen;
+	int datastart;
+	int i;
+
+	memset(&frame, 0, sizeof(frame));
+
+	/* Find first non-hex and non-space character:
+	 *  - In the simplest case, there is none.
+	 *  - For RTR frames, 'R' is the first non-hex character.
+	 *  - An error message may replace the end of the data line.
+	 */
+	for (hexlen = 0; hexlen <= len; hexlen++) {
+		if (hex_to_bin(elm->rxbuf[hexlen]) < 0 &&
+		    elm->rxbuf[hexlen] != ' ') {
+			break;
+		}
+	}
+
+	/* If we accept stray characters coming in:
+	 * Check for stray characters on a payload line.
+	 * No idea what causes this.
+	 */
+	if (accept_flaky_uart &&
+	    hexlen < len &&
+	    !isdigit(elm->rxbuf[hexlen]) &&
+	    !isupper(elm->rxbuf[hexlen]) &&
+	    '<' != elm->rxbuf[hexlen] &&
+	    ' ' != elm->rxbuf[hexlen]) {
+		/* The line is likely garbled anyway, so bail.
+		 * The main code will restart listening.
+		 */
+		elm327_kick_into_cmd_mode(elm);
+		return 3;
+	}
+
+	/* Use spaces in CAN ID to distinguish 29 or 11 bit address length.
+	 * No out-of-bounds access:
+	 * We use the fact that we can always read from elm->rxbuf.
+	 */
+	if (elm->rxbuf[2] == ' ' && elm->rxbuf[5] == ' ' &&
+	    elm->rxbuf[8] == ' ' && elm->rxbuf[11] == ' ' &&
+	    elm->rxbuf[13] == ' ') {
+		frame.can_id = CAN_EFF_FLAG;
+		datastart = 14;
+	} else if (elm->rxbuf[3] == ' ' && elm->rxbuf[5] == ' ') {
+		frame.can_id = 0;
+		datastart = 6;
+	} else {
+		/* This is not a well-formatted data line.
+		 * Assume it's an error message.
+		 */
+		return 1;
+	}
+
+	if (hexlen < datastart) {
+		/* The line is too short to be a valid frame hex dump.
+		 * Something interrupted the hex dump or it is invalid.
+		 */
+		return 1;
+	}
+
+	/* From here on all chars up to buf[hexlen] are hex or spaces,
+	 * at well-defined offsets.
+	 */
+
+	/* Read CAN data length */
+	frame.can_dlc = (hex_to_bin(elm->rxbuf[datastart - 2]) << 0);
+
+	/* Read CAN ID */
+	if (frame.can_id & CAN_EFF_FLAG) {
+		frame.can_id |= (hex_to_bin(elm->rxbuf[0]) << 28)
+			      | (hex_to_bin(elm->rxbuf[1]) << 24)
+			      | (hex_to_bin(elm->rxbuf[3]) << 20)
+			      | (hex_to_bin(elm->rxbuf[4]) << 16)
+			      | (hex_to_bin(elm->rxbuf[6]) << 12)
+			      | (hex_to_bin(elm->rxbuf[7]) << 8)
+			      | (hex_to_bin(elm->rxbuf[9]) << 4)
+			      | (hex_to_bin(elm->rxbuf[10]) << 0);
+	} else {
+		frame.can_id |= (hex_to_bin(elm->rxbuf[0]) << 8)
+			      | (hex_to_bin(elm->rxbuf[1]) << 4)
+			      | (hex_to_bin(elm->rxbuf[2]) << 0);
+	}
+
+	/* Check for RTR frame */
+	if (elm->rxfill >= hexlen + 3 &&
+	    !memcmp(&elm->rxbuf[hexlen], "RTR", 3)) {
+		frame.can_id |= CAN_RTR_FLAG;
+	}
+
+	/* Is the line long enough to hold the advertised payload?
+	 * Note: RTR frames have a DLC, but no actual payload.
+	 */
+	if (!(frame.can_id & CAN_RTR_FLAG) &&
+	    (hexlen < frame.can_dlc * 3 + datastart)) {
+		/* Incomplete frame. */
+
+		/* Probably the ELM327's RS232 TX buffer was full.
+		 * Emit an error frame and exit.
+		 */
+		frame.can_id = CAN_ERR_FLAG | CAN_ERR_CRTL;
+		frame.can_dlc = CAN_ERR_DLC;
+		frame.data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		elm327_feed_frame_to_netdev(elm, &frame);
+
+		/* Signal failure to parse.
+		 * The line will be re-parsed as an error line, which will fail.
+		 * However, this will correctly drop the state machine back into
+		 * command mode.
+		 */
+		return 2;
+	}
+
+	/* Parse the data nibbles. */
+	for (i = 0; i < frame.can_dlc; i++) {
+		frame.data[i] = (hex_to_bin(elm->rxbuf[datastart + 3*i]) << 4)
+			      | (hex_to_bin(elm->rxbuf[datastart + 3*i + 1]));
+	}
+
+	/* Feed the frame to the network layer. */
+	elm327_feed_frame_to_netdev(elm, &frame);
+
+	return 0;
+}
+
+static void elm327_parse_line(struct elmcan *elm, int len)
+{
+	/* Skip empty lines */
+	if (!len)
+		return;
+
+	/* Skip echo lines */
+	if (elm->drop_next_line) {
+		elm->drop_next_line = 0;
+		return;
+	} else if (elm->rxbuf[0] == 'A' && elm->rxbuf[1] == 'T') {
+		return;
+	}
+
+	/* Regular parsing */
+	switch (elm->state) {
+	case ELM_RECEIVING:
+		if (elm327_parse_frame(elm, len)) {
+			/* Parse an error line. */
+			elm327_parse_error(elm, len);
+
+			/* Start afresh. */
+			elm327_kick_into_cmd_mode(elm);
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void elm327_handle_prompt(struct elmcan *elm)
+{
+	struct can_frame *frame = &elm->can_frame;
+	char local_txbuf[20];
+
+	if (!elm->cmds_todo) {
+		/* Enter CAN monitor mode */
+		elm327_send(elm, "ATMA\r", 5);
+		elm->state = ELM_RECEIVING;
+
+		return;
+	}
+
+	/* Reconfigure ELM327 step by step as indicated by elm->cmds_todo */
+	if (test_bit(TODO_INIT, &elm->cmds_todo)) {
+		strcpy(local_txbuf, *elm->next_init_cmd);
+
+		elm->next_init_cmd++;
+		if (!(*elm->next_init_cmd)) {
+			clear_bit(TODO_INIT, &elm->cmds_todo);
+			netdev_info(elm->dev, "Initialization finished.\n");
+		}
+
+	} else if (test_and_clear_bit(TODO_SILENT_MONITOR, &elm->cmds_todo)) {
+		sprintf(local_txbuf, "ATCSM%i\r",
+			!(!(elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)));
+
+	} else if (test_and_clear_bit(TODO_RESPONSES, &elm->cmds_todo)) {
+		sprintf(local_txbuf, "ATR%i\r",
+			!(elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY));
+
+	} else if (test_and_clear_bit(TODO_CAN_CONFIG, &elm->cmds_todo)) {
+		sprintf(local_txbuf, "ATPC\r");
+		set_bit(TODO_CAN_CONFIG_PART2, &elm->cmds_todo);
+
+	} else if (test_and_clear_bit(TODO_CAN_CONFIG_PART2, &elm->cmds_todo)) {
+		sprintf(local_txbuf, "ATPB%04X\r",
+			elm->can_config);
+
+	} else if (test_and_clear_bit(TODO_CANID_29BIT_HIGH, &elm->cmds_todo)) {
+		sprintf(local_txbuf, "ATCP%02X\r",
+			(frame->can_id & CAN_EFF_MASK) >> 24);
+
+	} else if (test_and_clear_bit(TODO_CANID_29BIT_LOW, &elm->cmds_todo)) {
+		sprintf(local_txbuf, "ATSH%06X\r",
+			frame->can_id & CAN_EFF_MASK & ((1 << 24) - 1));
+
+	} else if (test_and_clear_bit(TODO_CANID_11BIT, &elm->cmds_todo)) {
+		sprintf(local_txbuf, "ATSH%03X\r",
+			frame->can_id & CAN_SFF_MASK);
+
+	} else if (test_and_clear_bit(TODO_CAN_DATA, &elm->cmds_todo)) {
+		if (frame->can_id & CAN_RTR_FLAG) {
+			/* Send an RTR frame. Their DLC is fixed.
+			 * Some chips don't send them at all.
+			 */
+			sprintf(local_txbuf, "ATRTR\r");
+		} else {
+			/* Send a regular CAN data frame */
+			int i;
+
+			for (i = 0; i < frame->can_dlc; i++) {
+				sprintf(&local_txbuf[2 * i], "%02X",
+					frame->data[i]);
+			}
+
+			sprintf(&local_txbuf[2 * i], "\r");
+		}
+
+		elm->drop_next_line = 1;
+		elm->state = ELM_RECEIVING;
+	}
+
+	elm327_send(elm, local_txbuf, strlen(local_txbuf));
+}
+
+static bool elm327_is_ready_char(char c)
+{
+	/* Bits 0xc0 are sometimes set (randomly), hence the mask.
+	 * Probably bad hardware.
+	 */
+	return (c & 0x3f) == ELM327_READY_CHAR;
+}
+
+static void elm327_drop_bytes(struct elmcan *elm, int i)
+{
+	memmove(&elm->rxbuf[0], &elm->rxbuf[i], ELM327_SIZE_RXBUF - i);
+	elm->rxfill -= i;
+}
+
+static void elm327_parse_rxbuf(struct elmcan *elm)
+{
+	int len;
+
+	switch (elm->state) {
+	case ELM_NOTINIT:
+		elm->rxfill = 0;
+		break;
+
+	case ELM_GETMAGICCHAR:
+	{
+		/* Wait for 'y' or '>' */
+		int i;
+
+		for (i = 0; i < elm->rxfill; i++) {
+			if (elm->rxbuf[i] == ELM327_MAGIC_CHAR) {
+				elm327_send(elm, "\r", 1);
+				elm->state = ELM_GETPROMPT;
+				i++;
+				break;
+			} else if (elm327_is_ready_char(elm->rxbuf[i])) {
+				elm327_send(elm, ELM327_MAGIC_STRING, 1);
+				i++;
+				break;
+			}
+		}
+
+		elm327_drop_bytes(elm, i);
+
+		break;
+	}
+
+	case ELM_GETPROMPT:
+		/* Wait for '>' */
+		if (elm327_is_ready_char(elm->rxbuf[elm->rxfill - 1]))
+			elm327_handle_prompt(elm);
+
+		elm->rxfill = 0;
+		break;
+
+	case ELM_RECEIVING:
+		/* Find <CR> delimiting feedback lines. */
+		for (len = 0;
+		     (len < elm->rxfill) && (elm->rxbuf[len] != '\r');
+		     len++) {
+			/* empty loop */
+		}
+
+		if (len == ELM327_SIZE_RXBUF) {
+			/* Line exceeds buffer. It's probably all garbage.
+			 * Did we even connect at the right baud rate?
+			 */
+			netdev_err(elm->dev,
+				   "RX buffer overflow. Faulty ELM327 or UART?\n");
+			elm327_hw_failure(elm);
+			break;
+		} else if (len == elm->rxfill) {
+			if (elm327_is_ready_char(elm->rxbuf[elm->rxfill - 1])) {
+				/* The ELM327's AT ST response timeout ran out,
+				 * so we got a prompt.
+				 * Clear RX buffer and restart listening.
+				 */
+				elm->rxfill = 0;
+
+				elm327_handle_prompt(elm);
+				break;
+			}
+
+			/* No <CR> found - we haven't received a full line yet.
+			 * Wait for more data.
+			 */
+			break;
+		}
+
+		/* We have a full line to parse. */
+		elm327_parse_line(elm, len);
+
+		/* Remove parsed data from RX buffer. */
+		elm327_drop_bytes(elm, len + 1);
+
+		/* More data to parse? */
+		if (elm->rxfill)
+			elm327_parse_rxbuf(elm);
+	}
+}
+
+ /***********************************************************************
+  *		netdev							*
+  *									*
+  * (takes elm->lock)							*
+  ***********************************************************************/
+
+static int elmcan_netdev_open(struct net_device *dev)
+{
+	struct elmcan *elm = netdev_priv(dev);
+	int err;
+
+	spin_lock_bh(&elm->lock);
+	if (elm->hw_failure) {
+		netdev_err(elm->dev, "Refusing to open interface after a hardware fault has been detected.\n");
+		spin_unlock_bh(&elm->lock);
+		return -EIO;
+	}
+
+	if (!elm->tty) {
+		spin_unlock_bh(&elm->lock);
+		return -ENODEV;
+	}
+
+	/* open_candev() checks for elm->can.bittiming.bitrate != 0 */
+	err = open_candev(dev);
+	if (err) {
+		spin_unlock_bh(&elm->lock);
+		return err;
+	}
+
+	elm327_init(elm);
+	spin_unlock_bh(&elm->lock);
+
+	can_led_event(dev, CAN_LED_EVENT_OPEN);
+	elm->can.state = CAN_STATE_ERROR_ACTIVE;
+	netif_start_queue(dev);
+
+	return 0;
+}
+
+static int elmcan_netdev_close(struct net_device *dev)
+{
+	struct elmcan *elm = netdev_priv(dev);
+
+	spin_lock_bh(&elm->lock);
+	if (elm->tty) {
+		/* Interrupt whatever we're doing right now */
+		elm327_send(elm, ELM327_MAGIC_STRING, 1);
+
+		/* Clear the wakeup bit, as the netdev will be down and thus
+		 * the wakeup handler won't clear it
+		 */
+		clear_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
+
+		spin_unlock_bh(&elm->lock);
+
+		flush_work(&elm->tx_work);
+	} else {
+		spin_unlock_bh(&elm->lock);
+	}
+
+	elm->can.state = CAN_STATE_STOPPED;
+	netif_stop_queue(dev);
+	close_candev(dev);
+	can_led_event(dev, CAN_LED_EVENT_STOP);
+
+	return 0;
+}
+
+/* Send a can_frame to a TTY. */
+static netdev_tx_t elmcan_netdev_start_xmit(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+	struct elmcan *elm = netdev_priv(dev);
+	struct can_frame *frame = (struct can_frame *)skb->data;
+
+	if (skb->len != sizeof(struct can_frame))
+		goto out;
+
+	if (!netif_running(dev))  {
+		netdev_warn(elm->dev, "xmit: iface is down.\n");
+		goto out;
+	}
+
+	/* BHs are already disabled, so no spin_lock_bh().
+	 * See Documentation/networking/netdevices.txt
+	 */
+	spin_lock(&elm->lock);
+
+	/* We shouldn't get here after a hardware fault:
+	 * can_bus_off() calls netif_carrier_off()
+	 */
+	WARN_ON(elm->hw_failure);
+
+	if (!elm->tty ||
+	    elm->hw_failure ||
+	    elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
+		spin_unlock(&elm->lock);
+		goto out;
+	}
+
+	netif_stop_queue(dev);
+
+	elm327_send_frame(elm, frame);
+	spin_unlock(&elm->lock);
+
+	dev->stats.tx_packets++;
+	dev->stats.tx_bytes += frame->can_dlc;
+
+	can_led_event(dev, CAN_LED_EVENT_TX);
+
+out:
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops elmcan_netdev_ops = {
+	.ndo_open	= elmcan_netdev_open,
+	.ndo_stop	= elmcan_netdev_close,
+	.ndo_start_xmit	= elmcan_netdev_start_xmit,
+	.ndo_change_mtu	= can_change_mtu,
+};
+
+ /***********************************************************************
+  *		Line discipline						*
+  *									*
+  * (takes elm->lock)							*
+  ***********************************************************************/
+
+/* Get a reference to our struct, taking into account locks/refcounts.
+ * This is to ensure ordering in case we are shutting down, and to ensure
+ * there is a refcount at all (otherwise tty->disc_data may be freed and
+ * before we increment the refcount).
+ * Use this for anything that can race against elmcan_ldisc_close().
+ */
+static struct elmcan *get_elm(struct tty_struct *tty)
+{
+	struct elmcan *elm;
+	bool got_ref;
+
+	spin_lock_bh(&elmcan_discdata_lock);
+	elm = (struct elmcan *)tty->disc_data;
+
+	if (!elm) {
+		spin_unlock_bh(&elmcan_discdata_lock);
+		return NULL;
+	}
+
+	got_ref = atomic_inc_not_zero(&elm->refcount);
+	spin_unlock_bh(&elmcan_discdata_lock);
+
+	if (!got_ref)
+		return NULL;
+
+	return elm;
+}
+
+static void put_elm(struct elmcan *elm)
+{
+	atomic_dec(&elm->refcount);
+}
+
+static bool elmcan_is_valid_rx_char(char c)
+{
+	return (accept_flaky_uart ||
+		isdigit(c) ||
+		isupper(c) ||
+		c == ELM327_MAGIC_CHAR ||
+		c == ELM327_READY_CHAR ||
+		c == '<' ||
+		c == 'a' ||
+		c == 'b' ||
+		c == 'v' ||
+		c == '.' ||
+		c == '?' ||
+		c == '\r' ||
+		c == ' ');
+}
+
+/* Handle incoming ELM327 ASCII data.
+ * This will not be re-entered while running, but other ldisc
+ * functions may be called in parallel.
+ */
+static void elmcan_ldisc_rx(struct tty_struct *tty,
+			    const unsigned char *cp, char *fp, int count)
+{
+	struct elmcan *elm = get_elm(tty);
+
+	if (!elm)
+		return;
+
+	spin_lock_bh(&elm->lock);
+
+	if (elm->hw_failure)
+		goto out;
+
+	while (count-- && elm->rxfill < ELM327_SIZE_RXBUF) {
+		if (fp && *fp++) {
+			netdev_err(elm->dev, "Error in received character stream. Check your wiring.");
+
+			elm327_hw_failure(elm);
+
+			goto out;
+		}
+
+		/* Ignore NUL characters, which the PIC microcontroller may
+		 * inadvertently insert due to a known hardware bug.
+		 * See ELM327 documentation, which refers to a Microchip PIC
+		 * bug description.
+		 */
+		if (*cp != 0) {
+			/* Check for stray characters on the UART line.
+			 * Likely caused by bad hardware.
+			 */
+			if (!elmcan_is_valid_rx_char(*cp)) {
+				netdev_err(elm->dev,
+					   "Received illegal character %02x.\n",
+					   *cp);
+				elm327_hw_failure(elm);
+
+				goto out;
+			}
+
+			elm->rxbuf[elm->rxfill++] = *cp;
+		}
+
+		cp++;
+	}
+
+	if (count >= 0) {
+		netdev_err(elm->dev, "Receive buffer overflowed. Bad chip or wiring?");
+
+		elm327_hw_failure(elm);
+
+		goto out;
+	}
+
+	elm327_parse_rxbuf(elm);
+
+out:
+	spin_unlock_bh(&elm->lock);
+	put_elm(elm);
+}
+
+/* Write out remaining transmit buffer.
+ * Scheduled when TTY is writable.
+ */
+static void elmcan_ldisc_tx_worker(struct work_struct *work)
+{
+	/* No need to use get_elm() here, as we'll always flush workers
+	 * before destroying the elmcan object.
+	 */
+	struct elmcan *elm = container_of(work, struct elmcan, tx_work);
+	ssize_t actual;
+
+	spin_lock_bh(&elm->lock);
+	if (elm->hw_failure) {
+		spin_unlock_bh(&elm->lock);
+		return;
+	}
+
+	if (!elm->tty || !netif_running(elm->dev)) {
+		spin_unlock_bh(&elm->lock);
+		return;
+	}
+
+	if (elm->txleft <= 0)  {
+		/* Our TTY write buffer is empty:
+		 * Allow netdev to hand us another packet
+		 */
+		clear_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
+		spin_unlock_bh(&elm->lock);
+		netif_wake_queue(elm->dev);
+		return;
+	}
+
+	actual = elm->tty->ops->write(elm->tty, elm->txhead, elm->txleft);
+	if (actual < 0) {
+		netdev_err(elm->dev,
+			   "Failed to write to tty %s.\n",
+			   elm->tty->name);
+		elm327_hw_failure(elm);
+		spin_unlock_bh(&elm->lock);
+		return;
+	}
+
+	elm->txleft -= actual;
+	elm->txhead += actual;
+	spin_unlock_bh(&elm->lock);
+}
+
+/* Called by the driver when there's room for more data. */
+static void elmcan_ldisc_tx_wakeup(struct tty_struct *tty)
+{
+	struct elmcan *elm = get_elm(tty);
+
+	if (!elm)
+		return;
+
+	schedule_work(&elm->tx_work);
+
+	put_elm(elm);
+}
+
+/* ELM327 can only handle bitrates that are integer divisors of 500 kHz,
+ * or 7/8 of that. Divisors are 1 to 64.
+ * Currently we don't implement support for 7/8 rates.
+ */
+static const u32 elmcan_bitrate_const[64] = {
+	 7812,  7936,  8064,  8196,  8333,  8474,  8620,  8771,
+	 8928,  9090,  9259,  9433,  9615,  9803, 10000, 10204,
+	10416, 10638, 10869, 11111, 11363, 11627, 11904, 12195,
+	12500, 12820, 13157, 13513, 13888, 14285, 14705, 15151,
+	15625, 16129, 16666, 17241, 17857, 18518, 19230, 20000,
+	20833, 21739, 22727, 23809, 25000, 26315, 27777, 29411,
+	31250, 33333, 35714, 38461, 41666, 45454, 50000, 55555,
+	62500, 71428, 83333, 100000, 125000, 166666, 250000, 500000
+};
+
+/* Dummy needed to use bitrate_const */
+static int elmcan_do_set_bittiming(struct net_device *netdev)
+{
+	(void)netdev;
+
+	return 0;
+}
+
+static int elmcan_ldisc_open(struct tty_struct *tty)
+{
+	struct net_device *dev;
+	struct elmcan *elm;
+	int err;
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (!tty->ops->write)
+		return -EOPNOTSUPP;
+
+	dev = alloc_candev(sizeof(struct elmcan), 0);
+	if (!dev)
+		return -ENFILE;
+	elm = netdev_priv(dev);
+
+	elm->txbuf = kmalloc(ELM327_SIZE_TXBUF, GFP_KERNEL);
+	if (!elm->txbuf) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	/* Configure TTY interface */
+	tty->receive_room = 65536; /* We don't flow control */
+	elm->txleft = 0; /* Clear TTY TX buffer */
+	spin_lock_init(&elm->lock);
+	atomic_set(&elm->refcount, 1);
+	INIT_WORK(&elm->tx_work, elmcan_ldisc_tx_worker);
+
+	/* Configure CAN metadata */
+	elm->can.state = CAN_STATE_STOPPED;
+	elm->can.bitrate_const = elmcan_bitrate_const;
+	elm->can.bitrate_const_cnt = ARRAY_SIZE(elmcan_bitrate_const);
+	elm->can.do_set_bittiming = elmcan_do_set_bittiming;
+	elm->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
+
+	/* Configure netlink interface */
+	elm->dev = dev;
+	dev->netdev_ops = &elmcan_netdev_ops;
+
+	/* Mark ldisc channel as alive */
+	elm->tty = tty;
+	tty->disc_data = elm;
+
+	devm_can_led_init(elm->dev);
+
+	/* Let 'er rip */
+	err = register_candev(elm->dev);
+	if (err)
+		goto out_err;
+
+	netdev_info(elm->dev, "elmcan on %s.\n", tty->name);
+
+	return 0;
+
+out_err:
+	kfree(elm->txbuf);
+	free_candev(elm->dev);
+	return err;
+}
+
+/* Close down an elmcan channel.
+ * This means flushing out any pending queues, and then returning.
+ * This call is serialized against other ldisc functions:
+ * Once this is called, no other ldisc function of ours is entered.
+ *
+ * We also use this function for a hangup event.
+ */
+static void elmcan_ldisc_close(struct tty_struct *tty)
+{
+	struct elmcan *elm = get_elm(tty);
+
+	if (!elm)
+		return;
+
+	/* unregister_netdev() calls .ndo_stop() so we don't have to. */
+	unregister_candev(elm->dev);
+
+	/* Decrease the refcount twice, once for our own get_elm(),
+	 * and once to remove the count of 1 that we set in _open().
+	 * Once it reaches 0, we can safely destroy it.
+	 */
+	put_elm(elm);
+	put_elm(elm);
+
+	while (atomic_read(&elm->refcount) > 0)
+		msleep_interruptible(10);
+
+	/* At this point, all ldisc calls to us have become no-ops. */
+
+	flush_work(&elm->tx_work);
+
+	/* Mark channel as dead */
+	spin_lock_bh(&elm->lock);
+	tty->disc_data = NULL;
+	elm->tty = NULL;
+	spin_unlock_bh(&elm->lock);
+
+	netdev_info(elm->dev, "elmcan off %s.\n", tty->name);
+
+	kfree(elm->txbuf);
+	free_candev(elm->dev);
+}
+
+static int elmcan_ldisc_hangup(struct tty_struct *tty)
+{
+	elmcan_ldisc_close(tty);
+	return 0;
+}
+
+static int elmcan_ldisc_ioctl(struct tty_struct *tty, struct file *file,
+			      unsigned int cmd, unsigned long arg)
+{
+	struct elmcan *elm = get_elm(tty);
+	unsigned int tmp;
+
+	if (!elm)
+		return -EINVAL;
+
+	switch (cmd) {
+	case SIOCGIFNAME:
+		tmp = strnlen(elm->dev->name, IFNAMSIZ - 1) + 1;
+		if (copy_to_user((void __user *)arg, elm->dev->name, tmp)) {
+			put_elm(elm);
+			return -EFAULT;
+		}
+
+		put_elm(elm);
+		return 0;
+
+	case SIOCSIFHWADDR:
+		put_elm(elm);
+		return -EINVAL;
+
+	default:
+		put_elm(elm);
+		return tty_mode_ioctl(tty, file, cmd, arg);
+	}
+}
+
+static struct tty_ldisc_ops elmcan_ldisc = {
+	.owner		= THIS_MODULE,
+	.magic		= TTY_LDISC_MAGIC,
+	.name		= "elmcan",
+	.receive_buf	= elmcan_ldisc_rx,
+	.write_wakeup	= elmcan_ldisc_tx_wakeup,
+	.open		= elmcan_ldisc_open,
+	.close		= elmcan_ldisc_close,
+	.hangup		= elmcan_ldisc_hangup,
+	.ioctl		= elmcan_ldisc_ioctl,
+};
+
+static int __init elmcan_init(void)
+{
+	int status;
+
+	pr_info("ELM327 based best-effort CAN interface driver\n");
+	pr_info("This device is severely limited as a CAN interface, see documentation.\n");
+
+	status = tty_register_ldisc(N_ELMCAN, &elmcan_ldisc);
+	if (status)
+		pr_err("can't register line discipline\n");
+
+	return status;
+}
+
+static void __exit elmcan_exit(void)
+{
+	/* This will only be called when all channels have been closed by
+	 * userspace - tty_ldisc.c takes care of the module's refcount.
+	 */
+	int status;
+
+	status = tty_unregister_ldisc(N_ELMCAN);
+	if (status)
+		pr_err("Can't unregister line discipline (error: %d)\n",
+		       status);
+}
+
+module_init(elmcan_init);
+module_exit(elmcan_exit);
diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
index 376cccf39..fc3ca7f14 100644
--- a/include/uapi/linux/tty.h
+++ b/include/uapi/linux/tty.h
@@ -38,5 +38,6 @@
 #define N_NCI		25	/* NFC NCI UART */
 #define N_SPEAKUP	26	/* Speakup communication with synths */
 #define N_NULL		27	/* Null ldisc used for error handling */
+#define N_ELMCAN	28	/* Serial / USB serial OBD-II Interfaces */
 
 #endif /* _UAPI_LINUX_TTY_H */
-- 
2.11.0

