Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192482FB9E1
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 15:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbhASOiy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 09:38:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:49562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387599AbhASJe5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 19 Jan 2021 04:34:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611048792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T17yGg+SFCTvViuHxcXtJf5jHe64yM2cb/CZLi8hhL4=;
        b=Rhz5adaedWgSfufJIg7X0Kx2t5UaHxY2HEnIX069TJR6jEQoQ8peONHffGArLvatV/fymv
        2yw0pv+le2h465NcmwSHMzcNfxggZfQbKj6h5ssDvKyOBM9zZCXKHrb7dY8CmZiuwTiW0b
        TqAiwzknbKlFw1nn1iQiwjYI8QjsqxI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38A3AB707;
        Tue, 19 Jan 2021 09:33:12 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v2 6/6] can: Update contact details
Date:   Tue, 19 Jan 2021 09:31:43 +0000
Message-Id: <20210119093143.17222-7-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119093143.17222-1-rpalethorpe@suse.com>
References: <20210119093143.17222-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

socketcan-users appears to be no more.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/network/can/filter-tests/00_Descriptions.txt | 5 +++--
 testcases/network/can/filter-tests/Makefile            | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/network/can/filter-tests/00_Descriptions.txt b/testcases/network/can/filter-tests/00_Descriptions.txt
index 55d213456..9623d29a0 100644
--- a/testcases/network/can/filter-tests/00_Descriptions.txt
+++ b/testcases/network/can/filter-tests/00_Descriptions.txt
@@ -6,5 +6,6 @@ information on the CAN network protocol family PF_CAN is contained in
 
 For any issue(s) with CAN tests please write to:
 <ltp@lists.linux.it>
-<socketcan-users@lists.berlios.de>,
-Oliver Hartkopp <oliver.hartkopp@volkswagen.de>,
+Oliver Hartkopp <socketcan@hartkopp.net>
+Linux-CAN ML <linux-can@vger.kernel.org>
+
diff --git a/testcases/network/can/filter-tests/Makefile b/testcases/network/can/filter-tests/Makefile
index 29aaa3240..bd57c7fff 100644
--- a/testcases/network/can/filter-tests/Makefile
+++ b/testcases/network/can/filter-tests/Makefile
@@ -14,8 +14,6 @@
 #    You should have received a copy of the GNU General Public License along
 #    with this program; if not, write to the Free Software Foundation, Inc.,
 #    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-#  Send feedback to <socketcan-users@lists.berlios.de>
 
 top_srcdir		?= ../../../..
 
-- 
2.29.2

