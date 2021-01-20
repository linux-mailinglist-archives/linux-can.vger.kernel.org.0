Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C482FD2E0
	for <lists+linux-can@lfdr.de>; Wed, 20 Jan 2021 15:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390416AbhATOie (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jan 2021 09:38:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:60498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390494AbhATOiZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 20 Jan 2021 09:38:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611153458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8bxkecA30vKpvKXV5/2+zt45Y6vrE4AWViiGp85qzs=;
        b=XthkpOnZxxtc//TIr/0+IE/0iE77xtWE/aVa3MZIHQjYwbEhjNNXGOCLaRWDqt3cnJjGFf
        AjYaR8sU1jwYvCtB+PWHrR43eG9ejq7euylHE0vQdHgP6wjowLKDNllTzeYfD2FJTlnQny
        N7jSaKnGLazS+AR/i+8sXsms/eLqOR0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 790A5ACE1;
        Wed, 20 Jan 2021 14:37:38 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v3 3/7] can: Add COPYING with dual license text
Date:   Wed, 20 Jan 2021 14:37:19 +0000
Message-Id: <20210120143723.26483-4-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120143723.26483-1-rpalethorpe@suse.com>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
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

