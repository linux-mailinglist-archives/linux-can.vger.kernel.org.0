Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0038B7BB554
	for <lists+linux-can@lfdr.de>; Fri,  6 Oct 2023 12:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjJFKd7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Oct 2023 06:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjJFKd4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Oct 2023 06:33:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDA8BE
        for <linux-can@vger.kernel.org>; Fri,  6 Oct 2023 03:33:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qoi9R-0003Mi-Bu; Fri, 06 Oct 2023 12:33:45 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qoi9O-00BUbQ-I4; Fri, 06 Oct 2023 12:33:42 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qoi9O-00D3kd-FU; Fri, 06 Oct 2023 12:33:42 +0200
Date:   Fri, 6 Oct 2023 12:33:42 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
        stable@vger.kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Sili Luo <rootlab@huawei.com>,
        davem@davemloft.net
Subject: Re: [PATCH net 1/7] can: j1939: Fix UAF in j1939_sk_match_filter
 during setsockopt(SO_J1939_FILTER)
Message-ID: <20231006103342.GA3112038@pengutronix.de>
References: <20231005094639.387019-1-mkl@pengutronix.de>
 <20231005094639.387019-2-mkl@pengutronix.de>
 <20231005094421.09a6a58f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231005094421.09a6a58f@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jakub,

On Thu, Oct 05, 2023 at 09:44:21AM -0700, Jakub Kicinski wrote:
> On Thu,  5 Oct 2023 11:46:33 +0200 Marc Kleine-Budde wrote:
> > Lock jsk->sk to prevent UAF when setsockopt(..., SO_J1939_FILTER, ...)
> > modifies jsk->filters while receiving packets.
> 
> Doesn't it potentially introduce sleep in atomic?
> 
> j1939_sk_recv_match()
>   spin_lock_bh(&priv->j1939_socks_lock);
>   j1939_sk_recv_match_one()
>     j1939_sk_match_filter()
>       lock_sock()
>         sleep

Good point! Thank you for the review.

@Sili Luo, can you please take a look at this?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
