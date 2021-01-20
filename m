Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4132FD2DE
	for <lists+linux-can@lfdr.de>; Wed, 20 Jan 2021 15:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390601AbhATOi3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jan 2021 09:38:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:60476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390416AbhATOiZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 20 Jan 2021 09:38:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611153458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6hdMxU6bfIY9nuDlBnPbWgIEEGZnE8NhXKn9sSPVlQ=;
        b=cTM2ED8VOEeu4a0EtFT7NRrUIuwvxQSK3b5jmw8koWkCC3j5npjoaLQkPf1ycNC9jG08Ly
        yKrUdpOO2OSObRUuG6zzevi/Yik3JY5flwjMGXn1dG/g16mrRr/2YyoSWzOrhGARl8JNtI
        /PXXX7339IpzSA8s1oifkx7CrF/ct+U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1820AACAD;
        Wed, 20 Jan 2021 14:37:38 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v3 2/7] can: Add can_common.h for vcan device setup
Date:   Wed, 20 Jan 2021 14:37:18 +0000
Message-Id: <20210120143723.26483-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120143723.26483-1-rpalethorpe@suse.com>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Note that we call modprobe to set echo=1. However this does seem to be
necessary for the current tests on 5.10. It has been kept to avoid
changing the test behavior unnecessarily, but can most likely be
safely removed if it causes problems.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../network/can/filter-tests/can_common.h     | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 testcases/network/can/filter-tests/can_common.h

diff --git a/testcases/network/can/filter-tests/can_common.h b/testcases/network/can/filter-tests/can_common.h
new file mode 100644
index 000000000..f15145f30
--- /dev/null
+++ b/testcases/network/can/filter-tests/can_common.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 SUSE LLC
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+
+#include "tst_cmd.h"
+#include "tst_safe_stdio.h"
+#include "tst_safe_file_ops.h"
+
+#include <linux/if.h>
+#include <linux/can.h>
+#include <linux/can/raw.h>
+
+#ifndef IFF_ECHO
+# define IFF_ECHO (1<<18)
+#endif
+
+static char *can_dev_name;
+static int can_created_dev;
+
+static void can_cmd(const char *const argv[])
+{
+	tst_cmd(argv, NULL, NULL, TST_CMD_TCONF_ON_MISSING);
+}
+
+#define CAN_CMD(...) can_cmd((const char *const[]){ __VA_ARGS__, NULL })
+
+static void can_setup_vcan(void)
+{
+	unsigned int flags;
+	char *path;
+
+	if (can_dev_name)
+		goto check_echo;
+
+	can_dev_name = "vcan0";
+
+	tst_res(TINFO, "Creating vcan0 device; use -D option to avoid this");
+
+	CAN_CMD("modprobe", "-r", "vcan");
+	CAN_CMD("modprobe", "vcan", "echo=1");
+
+	can_created_dev = 1;
+
+	CAN_CMD("ip", "link", "add", "dev", "vcan0", "type", "vcan");
+	CAN_CMD("ip", "link", "set", "dev", "vcan0", "up");
+
+check_echo:
+	/* Precondition for the frame flow test? */
+	SAFE_ASPRINTF(&path, "/sys/class/net/%s/flags", can_dev_name);
+	if (FILE_SCANF(path, "%x", &flags) || !(flags & IFF_ECHO)) {
+		tst_res(TWARN, "Could not determine if ECHO is set on %s",
+			can_dev_name);
+	}
+}
+
+static void can_cleanup_vcan(void)
+{
+	if (!can_created_dev)
+		return;
+
+	CAN_CMD("ip", "link", "set", "dev", "vcan0", "down");
+	CAN_CMD("ip", "link", "del", "dev", "vcan0");
+	CAN_CMD("modprobe", "-r", "vcan");
+}
-- 
2.30.0

