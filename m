Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0EE5F77AB
	for <lists+linux-can@lfdr.de>; Fri,  7 Oct 2022 13:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJGLum (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Oct 2022 07:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJGLul (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Oct 2022 07:50:41 -0400
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9417B7ECB
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 04:50:39 -0700 (PDT)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 0CA3920242
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 11:50:39 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id B84C2267CE
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 11:50:36 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 8BFFA3F1CC;
        Fri,  7 Oct 2022 13:50:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id E78982A3F4;
        Fri,  7 Oct 2022 11:50:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3KcQMrQV-cK2; Fri,  7 Oct 2022 11:50:33 +0000 (UTC)
Received: from mail15.mymailcheap.com (mail15.mymailcheap.com [141.94.164.103])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri,  7 Oct 2022 11:50:33 +0000 (UTC)
Received: from daniel6430.localnet (c-73-64-181-209.hsd1.pa.comcast.net [73.64.181.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail15.mymailcheap.com (Postfix) with ESMTPSA id E078720033;
        Fri,  7 Oct 2022 11:50:30 +0000 (UTC)
From:   "Daniel S. Trevitz" <dan@sstrev.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: Re: [PATCH 1/1] Termination resistor documentation
Date:   Fri, 07 Oct 2022 07:50:28 -0400
Message-ID: <2073121.tdWV9SEqCh@daniel6430>
In-Reply-To: <20221007111448.vlgmz7ih7coozwdd@pengutronix.de>
References: <4514353.LvFx2qVVIh@daniel6430> <5016474.31r3eYUQgx@daniel6430> <20221007111448.vlgmz7ih7coozwdd@pengutronix.de>
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

On Friday, October 7, 2022 7:14:48 AM EDT Marc Kleine-Budde wrote:
> On 07.10.2022 06:37:24, Daniel S. Trevitz wrote:
> > On Friday, October 7, 2022 3:41:17 AM EDT Marc Kleine-Budde wrote:
> > > On 06.10.2022 15:27:50, Daniel S. Trevitz wrote:
> > > > Add documentation for how to use and setup the switchable termination
> > > > resistor support for the can-controllers.
> > > > 
> > > > Signed-off-by: Daniel Trevitz <dan@sstrev.com>
> > > > ---
> > > > 
> > > >  Documentation/networking/can.rst | 30 ++++++++++++++++++++++++++++++
> > > >  1 file changed, 30 insertions(+)
> > > > 
> > > > diff --git a/Documentation/networking/can.rst
> > > > b/Documentation/networking/can.rst index ebc822e605f5..bb39cfa4c502
> > > > 100644
> > > > --- a/Documentation/networking/can.rst
> > > > +++ b/Documentation/networking/can.rst
> > > > @@ -1148,6 +1148,36 @@ tuning on deep embedded systems'. The author is
> > > > running a MPC603e>
> > > > 
> > > >  load without any problems ...
> > > > 
> > > > +Switchable Termination Resistors
> > > > +--------------------------------
> > > > +
> > > > +CAN bus requires a specific impedance across the differential pair,
> > > > +typically provided by two 120Ohm resistors on the farthest nodes of
> > > > +the bus. Some CAN controllers support activating / deactivating a
> > > > +termination resistor(s) to provide the correct impedance.::
> > > > +
> > > 
> > > > +  - Query the available resistances:
> > > You need double :: followed by a newline to mark as code.
> > 
> > This whole section is a code block; :: is up three lines.
> 
> Yes, your're right. What about making only the individual commands code?
> 
> Marc
Tested, looks fine as individual blocks; v3 coming in hot.
-Daniel



