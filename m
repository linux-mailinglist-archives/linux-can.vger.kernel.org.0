Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451EE4DE7F6
	for <lists+linux-can@lfdr.de>; Sat, 19 Mar 2022 13:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242324AbiCSM4l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 19 Mar 2022 08:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiCSM4l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Mar 2022 08:56:41 -0400
X-Greylist: delayed 472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Mar 2022 05:55:18 PDT
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8561D1EF5CC
        for <linux-can@vger.kernel.org>; Sat, 19 Mar 2022 05:55:18 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id D705F30F5B47;
        Sat, 19 Mar 2022 13:46:53 +0100 (CET)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id F1E4130EE969;
        Sat, 19 Mar 2022 13:46:52 +0100 (CET)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 22JCkqc6021696;
        Sat, 19 Mar 2022 13:46:52 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 22JCkqeW021694;
        Sat, 19 Mar 2022 13:46:52 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: [PATCH] can: bittiming: can_calc_bittiming(): prefer small bit rate pre-scalers over larger ones
Date:   Sat, 19 Mar 2022 13:46:42 +0100
User-Agent: KMail/1.9.10
Cc:     linux-can@vger.kernel.org, Srinivas Neeli <sneeli@xilinx.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <20220318144913.873614-1-mkl@pengutronix.de>
In-Reply-To: <20220318144913.873614-1-mkl@pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202203191346.42561.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc and others,

On Friday 18 of March 2022 15:49:13 Marc Kleine-Budde wrote:
> The CiA (CAN into Automation) lists in their Newsletter 1/2018 in the
> "Recommendation for the CAN FD bit-timing" [1] article several
>
> recommendations, one of them is:
> | Recommendation 3: Choose BRPA and BRPD as low as possible
>
> [1]
> https://can-newsletter.org/uploads/media/raw/f6a36d1461371a2f86ef0011a51371
>2c.pdf
>
> With the current bit timing algorithm Srinivas Neeli noticed that on
> the Xilinx Versal ACAP board the CAN data bit timing parameters are
> not calculated optimally. For most bit rates, the bit rate
> prescaler (BRP) is != 1, although it's possible to configure the

I have already thought about algorithm and optimal number of bitquanta
per bittime. In the fact, I think than original LinCAN algorithm version
which I have provided for SocketCAN used reversed preference for BPR.
But I think that too small or too big ratio is bad. So for our actual
NuttX ESP32C3 driver developed by our studnet Jan Charvat, I consider
to add some mechanism how to specify optimal bitquanta per bittime
ratio. The question is if that should be additional parameter
in the struct can_bittiming_const

  https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/can/netlink.h#L47

or if that should be some constant defined for data bitrate
and probably the second for arbitration bitrate.

If there is interrest I try to provide some patch which
would prefer the nearest suitable BPR to optimal
timequanta to bittime ratio.  

Best wishes,


                Pavel
--
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

