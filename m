Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937725F76F9
	for <lists+linux-can@lfdr.de>; Fri,  7 Oct 2022 12:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJGKhk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Oct 2022 06:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJGKhb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Oct 2022 06:37:31 -0400
X-Greylist: delayed 54571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Oct 2022 03:37:29 PDT
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71651D57D2
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 03:37:29 -0700 (PDT)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 00F183ECD9;
        Fri,  7 Oct 2022 12:37:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id EB8662A7D6;
        Fri,  7 Oct 2022 10:37:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 30-xcSmCWviF; Fri,  7 Oct 2022 10:37:26 +0000 (UTC)
Received: from mail15.mymailcheap.com (mail15.mymailcheap.com [141.94.164.103])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Fri,  7 Oct 2022 10:37:26 +0000 (UTC)
Received: from daniel6430.localnet (c-73-64-181-209.hsd1.pa.comcast.net [73.64.181.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail15.mymailcheap.com (Postfix) with ESMTPSA id B26EE202C4;
        Fri,  7 Oct 2022 10:37:25 +0000 (UTC)
From:   "Daniel S. Trevitz" <dan@sstrev.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: Re: [PATCH 1/1] Termination resistor documentation
Date:   Fri, 07 Oct 2022 06:37:24 -0400
Message-ID: <5016474.31r3eYUQgx@daniel6430>
In-Reply-To: <20221007074117.5enbqlt4fno7vtlz@pengutronix.de>
References: <4514353.LvFx2qVVIh@daniel6430> <20221007074117.5enbqlt4fno7vtlz@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Friday, October 7, 2022 3:41:17 AM EDT Marc Kleine-Budde wrote:
> On 06.10.2022 15:27:50, Daniel S. Trevitz wrote:
> > Add documentation for how to use and setup the switchable termination
> > resistor support for the can-controllers.
> > 
> > Signed-off-by: Daniel Trevitz <dan@sstrev.com>
> > ---
> > 
> >  Documentation/networking/can.rst | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/Documentation/networking/can.rst
> > b/Documentation/networking/can.rst index ebc822e605f5..bb39cfa4c502
> > 100644
> > --- a/Documentation/networking/can.rst
> > +++ b/Documentation/networking/can.rst
> > @@ -1148,6 +1148,36 @@ tuning on deep embedded systems'. The author is
> > running a MPC603e> 
> >  load without any problems ...
> > 
> > +Switchable Termination Resistors
> > +--------------------------------
> > +
> > +CAN bus requires a specific impedance across the differential pair,
> > +typically provided by two 120Ohm resistors on the farthest nodes of
> > +the bus. Some CAN controllers support activating / deactivating a
> > +termination resistor(s) to provide the correct impedance.::
> > +
> 
> > +  - Query the available resistances:
> You need double :: followed by a newline to mark as code.
This whole section is a code block; :: is up three lines.
> 
> > +      $ ip -details link show can0
> > +      ...
> > +      termination 120 [ 0, 120
> 
> The closing ] is missing, please add it, even if the current ip command
> doesn't print it. I just noticed it got lost in a cleanup patch in
> iproute2.
Okay
> 
> > +
> 
> > +  - Activate the terminating resistor:
> same here
> 
> > +      $ ip link set dev can0 type can termination 120
> > +
> 
> > +  - Deactivate the terminating resistor:
> same here
> 
> > +      $ ip link set dev can0 type can termination 0
> > +
> > +To enable termination resistor support to a can-controller, either
> > +implement in the controller's struct can-priv::
> > +
> > +    termination_const
> > +    termination_const_cnt
> > +    do_set_termination
> > +
> > +or add gpio control with the device tree entries from
> > +Documentation/devicetree/bindings/net/can/can-controller.yaml
> > +
> > +
> > 
> >  The Virtual CAN Driver (vcan)
> >  -----------------------------
> 
> Marc

-Dan



