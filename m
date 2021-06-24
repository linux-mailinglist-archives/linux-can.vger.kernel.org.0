Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0973B2ADC
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbhFXJBx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 05:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhFXJBx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 05:01:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95231C061574
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 01:59:33 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lwLCt-000398-FM; Thu, 24 Jun 2021 10:59:31 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lwLCt-0001nv-5m; Thu, 24 Jun 2021 10:59:31 +0200
Date:   Thu, 24 Jun 2021 10:59:31 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC]: can-next 2021-06-21: try to fix softirq error from
 threaded IRQs
Message-ID: <20210624085931.6r4ogebagp3g5fsj@pengutronix.de>
References: <20210621123436.2897023-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210621123436.2897023-1-mkl@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:56:54 up 203 days, 23:03, 45 users,  load average: 0.15, 0.12,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jun 21, 2021 at 02:34:28PM +0200, Marc Kleine-Budde wrote:
> Hello,
> 
> this series tries to fix the softirq error which occurs if NAPI is
> scheduled from threaded IRQ context [1][2]. Also it fixes a RX-before-TX
> problem seen on the mcp251xfd driver.
> 
> regards,
> Marc
> 
> [1] https://lore.kernel.org/r/20210310064626.GA11893@homes.emlix.com
> [2] http://lore.kernel.org/r/CAOMZO5AMP537Qz1MAb-D_27C=WH-5Cf602hichxty95A6db9-A@mail.gmail.com

Tested on imx6qp with flexcan and mcp251xfd. J1939 works fine, no
RX-before-TX issue was detected (can speed 250K). No lockdep warnings.

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
