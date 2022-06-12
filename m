Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17F547C73
	for <lists+linux-can@lfdr.de>; Sun, 12 Jun 2022 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiFLV2P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Sun, 12 Jun 2022 17:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiFLV2N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 12 Jun 2022 17:28:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6A3724951
        for <linux-can@vger.kernel.org>; Sun, 12 Jun 2022 14:28:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-23-xpV4lFl0PfStBSylmoAXEA-1; Sun, 12 Jun 2022 22:28:08 +0100
X-MC-Unique: xpV4lFl0PfStBSylmoAXEA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Sun, 12 Jun 2022 22:28:06 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Sun, 12 Jun 2022 22:28:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rhett Aultman' <rhett.aultman@samsara.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-can <linux-can@vger.kernel.org>
CC:     --cc=Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: RE: [PATCH v3 2/2] can: gs_usb: fix DMA memory leak on close
Thread-Topic: [PATCH v3 2/2] can: gs_usb: fix DMA memory leak on close
Thread-Index: AQHYfRHs6SXKDKJ+HESTVsEc7tmfzq1MTE/A
Date:   Sun, 12 Jun 2022 21:28:06 +0000
Message-ID: <0b792b543f5f4b70ab9e102825329474@AcuMS.aculab.com>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-3-rhett.aultman@samsara.com>
In-Reply-To: <20220610213335.3077375-3-rhett.aultman@samsara.com>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Rhett Aultman
> Sent: 10 June 2022 22:34
> 
> The gs_usb driver allocates DMA memory with usb_alloc_coherent() in
> gs_can_open() and then keeps this memory in an URB, with the expectation
> that the memory will be freed when the URB is killed in gs_can_close().
> Memory allocated with usb_alloc_coherent() cannot be freed in this way
> and must be freed using usb_free_coherent() instead.  This means that
> repeated cycles of calling gs_can_open() and gs_can_close() will lead to
> a memory leak.
> 
> Historically, drivers have handled this by keeping an array of pointers
> to their DMA rx buffers and explicitly freeing them.  For an example of
> this technique used in the esd_usb2 driver, see here:
> https://www.spinics.net/lists/linux-can/msg08203.html
> 
> While the above method works, the conditions that cause this leak are
> not apparent to driver writers and the method for solving it at the
> driver level has been piecemeal.  This patch makes use of a new
> URB_FREE_COHERENT flag on the URB, reducing the solution of this memory
> leak down to a single line of code.
> 
> Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/usb/gs_usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index b29ba9138866..4e7e6a7b961a 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -768,7 +768,7 @@ static int gs_can_open(struct net_device *netdev)
>  					  buf,
>  					  dev->parent->hf_size_rx,
>  					  gs_usb_receive_bulk_callback, parent);
> -			urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
> +			urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP | URB_FREE_COHERENT;

Should that be clearing any other flags?

	David

> 
>  			usb_anchor_urb(urb, &parent->rx_submitted);
> 
> --
> 2.30.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

