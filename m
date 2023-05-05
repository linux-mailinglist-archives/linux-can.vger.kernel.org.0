Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB06F80C5
	for <lists+linux-can@lfdr.de>; Fri,  5 May 2023 12:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjEEKbr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 May 2023 06:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjEEKbq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2023 06:31:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB9D19905
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 03:31:42 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1pusix-0000ZF-Fj; Fri, 05 May 2023 12:31:39 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1pusiw-0007jd-Oq; Fri, 05 May 2023 12:31:38 +0200
Date:   Fri, 5 May 2023 12:31:38 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: allow MSG_CMSG_COMPAT flag in recvmsg() syscalls
Message-ID: <20230505103138.GF6255@pengutronix.de>
References: <20230406110845.5180-1-socketcan@hartkopp.net>
 <dbf2020b-98bc-9ca2-ed54-8f86bdb99ee8@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbf2020b-98bc-9ca2-ed54-8f86bdb99ee8@hartkopp.net>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

Sorry for long delay.

On Thu, Apr 06, 2023 at 01:25:11PM +0200, Oliver Hartkopp wrote:
> I should probably split this into two patches when thinking of stable
> kernels.

yes, please.

> E.g. we have to handle two "Fixes:" tags here:
> 
> Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading from
> socket")
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> 
> @Oleksij: Can you please check if adding this flag is fine for you too - and
> if you can "ack" it?

I tested it on imx8mp with 64bit kernel and 32bit user space. Without
this patch "j1939spy -P vcan0" is not working. So, here is my:
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
