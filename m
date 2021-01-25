Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DE30361E
	for <lists+linux-can@lfdr.de>; Tue, 26 Jan 2021 07:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbhAZGBT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jan 2021 01:01:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:57058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbhAYJeV (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 25 Jan 2021 04:34:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19B4BAB9F;
        Mon, 25 Jan 2021 09:10:29 +0000 (UTC)
Date:   Mon, 25 Jan 2021 10:10:27 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     ltp@lists.linux.it, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Subject: Re: [LTP] [PATCH v3 6/7] can: Remove obsolete test wrapper script
Message-ID: <YA6LA4rSb9obia6k@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-7-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120143723.26483-7-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Richie,

>  2) To Run the tests from this directory, do:
> -$ ./run_ltp-can_tests.sh
> +$ ./can_filter
> +$ ./can_rcv_own_msgs
>  3) To let LTP run the tests from $LTPROOT, execute:
>  $ ./runltp -f can

You also need to update runtest/can (which can be done during merge).

diff --git runtest/can runtest/can
index 6aa2ae9f5..b637183c6 100644
--- runtest/can
+++ runtest/can
@@ -1,2 +1,2 @@
-can_filter can_run_tests.sh can_filter
-can_rcv_own_msgs can_run_tests.sh can_rcv_own_msgs
+can_filter can_filter
+can_rcv_own_msgs can_rcv_own_msgs

Whole patchset LGTM, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
