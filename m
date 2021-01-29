Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C92F308AE8
	for <lists+linux-can@lfdr.de>; Fri, 29 Jan 2021 18:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhA2RFD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Jan 2021 12:05:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:49986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231532AbhA2REk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 29 Jan 2021 12:04:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611939834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v35pcEft139R61SIwS1Cy+bxWJY6+YlpgwUfNsVF4vg=;
        b=tbiZca1+GB1kg39Rw0OUjpGih/Lq9+SJ4BsQx6iWYsOCEcF15LJJ9MdLJDAsZuraZ/7V1J
        jqNXUgzskPrpYF84MtKg+feQ9b6Khb1IxI2sNCVwCseqCxBEu6gmhXO4xlXV5hH3qGSk72
        XnuJ0IKHN8RLoxdiG1/DqYJmUrOKrok=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74A0BAD4E;
        Fri, 29 Jan 2021 17:03:54 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v4 3/7] can: Add COPYING with dual license text
Date:   Fri, 29 Jan 2021 17:03:01 +0000
Message-Id: <20210129170305.27383-4-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129170305.27383-1-rpalethorpe@suse.com>
References: <20210129170305.27383-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This may be referred to with

SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)

The kernel version includes the syscall note, but the contents of the
syscall note have never been included within the LTP CAN tests.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 testcases/network/can/filter-tests/COPYING | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 testcases/network/can/filter-tests/COPYING

diff --git a/testcases/network/can/filter-tests/COPYING b/testcases/network/can/filter-tests/COPYING
new file mode 100644
index 000000000..2fa5eb911
--- /dev/null
+++ b/testcases/network/can/filter-tests/COPYING
@@ -0,0 +1,35 @@
+Copyright (c) 2010-2011 Volkswagen Group Electronic Research
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+1. Redistributions of source code must retain the above copyright
+   notice, this list of conditions and the following disclaimer.
+2. Redistributions in binary form must reproduce the above copyright
+   notice, this list of conditions and the following disclaimer in the
+   documentation and/or other materials provided with the distribution.
+3. Neither the name of Volkswagen nor the names of its contributors
+   may be used to endorse or promote products derived from this software
+   without specific prior written permission.
+
+Alternatively, provided that this notice is retained in full, this
+software may be distributed under the terms of the GNU General
+Public License ("GPL") version 2, in which case the provisions of the
+GPL apply INSTEAD OF those given above.
+
+The provided data structures and external interfaces from this code
+are not restricted to be used by modules with a GPL compatible license.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+DAMAGE.
-- 
2.30.0

