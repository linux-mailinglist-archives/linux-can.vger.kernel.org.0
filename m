Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8443C6078CF
	for <lists+linux-can@lfdr.de>; Fri, 21 Oct 2022 15:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJUNot (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 21 Oct 2022 09:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiJUNor (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 21 Oct 2022 09:44:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4078439131
        for <linux-can@vger.kernel.org>; Fri, 21 Oct 2022 06:44:37 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1olsKB-0007Wv-41; Fri, 21 Oct 2022 15:44:35 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1olsK9-00010Z-Ku; Fri, 21 Oct 2022 15:44:33 +0200
Date:   Fri, 21 Oct 2022 15:44:33 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Sebastien FABRE <sebastien.fabre@actia.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: J1939: Send messages without acknowledging
Message-ID: <20221021134433.GG28729@pengutronix.de>
References: <PR0P264MB23096FC238E648331A32B5A492299@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
 <20221018110016.sgvh2prqm5ehstxv@pengutronix.de>
 <PR0P264MB23094D0D6CA05334809ACEE1922A9@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PR0P264MB23094D0D6CA05334809ACEE1922A9@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Sebastien,

On Thu, Oct 20, 2022 at 01:17:36PM +0000, Sebastien FABRE wrote:
> > On 17.10.2022 14:55:58, Sebastien FABRE wrote:
> > > Hello,
> > >
> > > I am working on 5.4 kernel, and I have the same behavior with 5.10
> > > kernel version.
> > >
> > > I reproduce the behavior with a custom application. A j1939 socket is
> > > created with SO_BROADCAST and SO_J1939_PROMISC options and is binded.
> > > The application sends a claim message then 50 broadcast messages in
> > > loop (without waiting) with size greater than 8 bytes (50).
> > >
> > > Every sendto methods return success directly and sessions are stored
> > > in sk_session_queue.
> > >
> > > If the can is 'on' but nobody acknowledges, after some times, trames
> > > are no longer sent (ENOBUFS) but the application does not have this
> > > information (sendto returned success).
> > >
> > > Moreover, txqueuelen does not have impact to this behavior (queue size
> > > seems to be infinite).
> > >
> > > To finish, closing socket will take a long time depending on
> > > sk_session_queue size because of J1939_XTP_TX_RETRY_LIMIT: kernel
> > > seems to try to send every message 100 times if ENOBUFS is received.
> > >
> > > Is it the expected behavior? How can the application know that
> > > messages are no longer sent?
> > 
> > It's sort of expected....I think we haven't thought of that corner case.
> > There is the socket TX timeout option, seems we have to implement this for
> > j1939.
> > 
> 
> I reproduced the same behaviour with updated testj1939 (so no claim message) to be able to send multiple messages.
> The tests have been done with peak can or flexcan.
> Should we limit the sk_session_queue size to not be able to have too many messages in this queue ? In this case, sendto will return an error (and not success) when it is full.

Can you reproduce same issue with j1939cat in broadcast mode?

The difference between testj1939 and j1939cat is the last one is
designed to get error/completion reports from the kernel J1939 stack.

Regards,
Oleksij

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
