Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574AC554685
	for <lists+linux-can@lfdr.de>; Wed, 22 Jun 2022 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiFVKDg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 22 Jun 2022 06:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243716AbiFVKDO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Jun 2022 06:03:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A44B813F86
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2022 03:03:12 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-253-kWKsfqdzMEiB4roPnVf7dw-1; Wed, 22 Jun 2022 11:03:09 +0100
X-MC-Unique: kWKsfqdzMEiB4roPnVf7dw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 22 Jun 2022 11:03:08 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 22 Jun 2022 11:03:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC:     'Vincent MAILHOL' <mailhol.vincent@wanadoo.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "Rhett Aultman" <rhett.aultman@samsara.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-can <linux-can@vger.kernel.org>,
        "Oliver Neukum" <oneukum@suse.com>
Subject: RE: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Thread-Topic: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Thread-Index: AQHYhYfqVaqlcIuK10S0028j1oZk3K1bJ6wg///04QCAABG7cA==
Date:   Wed, 22 Jun 2022 10:03:07 +0000
Message-ID: <186561fa929f459985ad2986936988e5@AcuMS.aculab.com>
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com>
 <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu>
 <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
 <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com>
 <YrLjsAOlsizMc/1c@kroah.com>
In-Reply-To: <YrLjsAOlsizMc/1c@kroah.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Greg Kroah-Hartman
> Sent: 22 June 2022 10:41
...
> > IIRC urb are pretty big.
> 
> What exactly do you mean by "pretty big" here?

Maybe 100-200 bytes?

> And what is wrong with
> that, I have never seen any issues with the current size of that
> structure in any benchmark or performance results.

Nothing really, the cost of allocating a sub-page structure
is pretty much independent of its size.
What I really meant is it isn't (say) 32 bytes where adding
another 4 could be a significant increase.

> All USB bottlenecks
> that I know of are either in the hardware layer, or in the protocol
> layer itself (i.e. usb-storage protocol).

There is a bufferbloat issue for usbnet on XHCI.
It would be better to fill the ring with (probably) 4k buffers
and have something sort out the USB frames from the buffers
and then get the network driver to use (IIRC) build_skb
to generate the skb from the data fragments.

I was only using 100M last time I was testing that and
didn't get performance issues.
Just problems with the USB connections 'bouncing', that
project got canned for other reasons ...

But at higher speeds and high network use it might all
be a problem.

> 
> > You'd be unlucky if adding an extra field to hold the allocated
> > size would ever need more memory.
> > So it might just be worth saving the allocated size.
> 
> Maybe, yes, then we could transition to allocating the urb and buffer at
> the same time like we do partially for iso streams in an urb.  But that
> still might be overkill for just this one driver.  I'm curious as to why
> a slow and tiny protocol like CAN needs to use usb_alloc_coherent() for
> its buffers in the first place.

Yes, being able to do short transfers from buffer space in the urb
would save all the issues about having to allocate an extra
buffer to avoid DMA from stack.

Indeed for XHCI there is a bit that allows 8 bytes of data to
replace the pointer in the ring structure itself.
I don't remember the driver every doing that.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

