Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A5B7B09
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2019 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403805AbfISNxV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Sep 2019 09:53:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43321 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403801AbfISNxU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Sep 2019 09:53:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id r9so3249474edl.10
        for <linux-can@vger.kernel.org>; Thu, 19 Sep 2019 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v3cetozOSZy7f/Jb6I8jeAIGwOyq+yRn9jMlpG/XHDQ=;
        b=q9jH6/UyuUfwQyQmHmMc9lPMvs7GsvW7K1vExtK953/36wEkAbgkv7lhZElTRSlSNa
         W7O+OQ/c3lO+YjUVG3GSvtF9G/yD92zeWiIZ40lbMXFJDFJmvQwTyp29h6ubrce9P1oN
         tTNKrWaaLpAvzHOUTuJf389slk+vNQPVXcmW9QKO6iWu+7iHb0FWBlrTYRJYgnsBk9DD
         F8Rta8UR5Ewx6hB4VM51/a0eg2vyfp3NIEB64kkAGWV9F9aY8GOEwFPyU4uEzCy0jj5n
         ahuw5AtH32jnny/M2KA+suLpQP42LNIZ/SLAoKAD545iMGiE2/8EJ2prD5YQnilIk65F
         9ovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v3cetozOSZy7f/Jb6I8jeAIGwOyq+yRn9jMlpG/XHDQ=;
        b=sILC7qqrqKTABGPaQdbanARmj0jAKBuc8it3BKtpihZw6guJFy/rbsdgMd+yamiXTj
         EP/rnUbTPB/NYszlW0TDdtoO8XWwW+/bR18wyog07aokRiRv+i1nB2jtbvCgoVS4Cm3t
         Zap5TpNt4KcyXPxeGHo54NEPUYOv+WsFU7zniuECzg1b82PZWtjWvPWZn2KpLFN4JBlY
         cTTuI0Y4brnssyOsju3/oe/fjVpGZf0+BxHQydQSOsdSYM+Q66kItvMiCu23JudMoulA
         iXIjnXOj+cUeVgjuKkaB69i6kM7d1x3IwGxXsTNAlDUwFSeaoyyJkhhBsRsZDB3auNPM
         kQqQ==
X-Gm-Message-State: APjAAAUpElXHIRHHpGz4pdG+KM1WPL8Os0Kd1gOGpi+9O82bDH+LwdG7
        ddSRnt0ikfxoOOIEbj8eQ43uS2bBHQg=
X-Google-Smtp-Source: APXvYqx/IfW83AWi0jnuYAjeIxBPa+h+jqzCVpMRkYxdqv1KaBjgRYN06BFaYJEwml9OQEV2lKJqPg==
X-Received: by 2002:a17:906:699:: with SMTP id u25mr8495418ejb.250.1568901197936;
        Thu, 19 Sep 2019 06:53:17 -0700 (PDT)
Received: from development1.visionsystems.de (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id c6sm635964ejz.79.2019.09.19.06.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 06:53:17 -0700 (PDT)
From:   yegorslists@googlemail.com
To:     linux-can@vger.kernel.org
Cc:     socketcan@hartkopp.net, mkl@pengutronix.de, wg@grandegger.com,
        Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] can: don't use deprecated license identifiers
Date:   Thu, 19 Sep 2019 15:53:04 +0200
Message-Id: <20190919135304.14757-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

GPL-2.0 license identifier changed to GPL-2.0-only in SPDX v3.0.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 include/uapi/linux/can/bcm.h     | 2 +-
 include/uapi/linux/can/error.h   | 2 +-
 include/uapi/linux/can/gw.h      | 2 +-
 include/uapi/linux/can/j1939.h   | 2 +-
 include/uapi/linux/can/netlink.h | 2 +-
 include/uapi/linux/can/raw.h     | 2 +-
 include/uapi/linux/can/vxcan.h   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.h
index 0fb328d93148..dd2b925b09ac 100644
--- a/include/uapi/linux/can/bcm.h
+++ b/include/uapi/linux/can/bcm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * linux/can/bcm.h
  *
diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
index bfc4b5d22a5e..34633283de64 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * linux/can/error.h
  *
diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index 3aea5388c8e4..c2190bbe21d8 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * linux/can/gw.h
  *
diff --git a/include/uapi/linux/can/j1939.h b/include/uapi/linux/can/j1939.h
index c32325342d30..df6e821075c1 100644
--- a/include/uapi/linux/can/j1939.h
+++ b/include/uapi/linux/can/j1939.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
  * j1939.h
  *
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 1bc70d3a4d39..6f598b73839e 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
  * linux/can/netlink.h
  *
diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index be3b36e7ff61..6a11d308eb5c 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * linux/can/raw.h
  *
diff --git a/include/uapi/linux/can/vxcan.h b/include/uapi/linux/can/vxcan.h
index 066812d118a2..4fa9d8777a07 100644
--- a/include/uapi/linux/can/vxcan.h
+++ b/include/uapi/linux/can/vxcan.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 #ifndef _UAPI_CAN_VXCAN_H
 #define _UAPI_CAN_VXCAN_H
 
-- 
2.17.0

