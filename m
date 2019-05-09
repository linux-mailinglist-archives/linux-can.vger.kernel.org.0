Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D719C19022
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2019 20:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEISXq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 May 2019 14:23:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:7347 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfEISXq (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 9 May 2019 14:23:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 11:23:45 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2019 11:23:43 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hOnhm-0002wD-Vj; Fri, 10 May 2019 02:23:42 +0800
Date:   Fri, 10 May 2019 02:23:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     kbuild-all@01.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC PATCH mkl-can-next] j1939:
 j1939_sk_get_timestamping_opt_stats() can be static
Message-ID: <20190509182315.GA155877@lkp-kbuild10>
References: <201905100252.18aBimi8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905100252.18aBimi8%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Fixes: 0d07d158907c ("j1939: add MSG_ERRQUEUE support")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 socket.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 658ee79..2982b3c 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -738,7 +738,7 @@ static size_t j1939_sk_opt_stats_get_size(void)
 		0;
 }
 
-struct sk_buff *j1939_sk_get_timestamping_opt_stats(struct j1939_session *session)
+static struct sk_buff *j1939_sk_get_timestamping_opt_stats(struct j1939_session *session)
 {
 	struct sk_buff *stats;
 
