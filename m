Return-Path: <linux-can+bounces-6548-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OgkE/hKj2moPQEAu9opvQ
	(envelope-from <linux-can+bounces-6548-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 17:02:00 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CAF137C91
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 17:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8B163032DEE
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7CA247295;
	Fri, 13 Feb 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Muig82Oy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE511E0DE8;
	Fri, 13 Feb 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998512; cv=none; b=kFHPn27YsoZEly6TphEBAlo0BugH5OY+sJDxOFkgf5oLn3BbQjDpZuR6RjmntEAxFAJlre4NELntgyk/qorZkN4POqi9Zbgi0oV4bZHzFPXSka7822fnngegkkmraeifErCqqx0yMFyPWCHeK603HVJPLDcfPL0bFg3jEKikQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998512; c=relaxed/simple;
	bh=53UIlOOH57Oi25hpAJSpEYDCkMejcnDHh/EgOEa9+uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrNUyZvSBUHJHhYKwKDAsr2wOJ8jIVyisF/kysZ33uAjsuT7+oe8vpITaMiSQK6WhkBhSjSeijflYuyJA8aJDaGfAHEcUOvMyk2JWPs8lgGQodX0HADjHhMVBDO61tbJsdnqaEU8lgUpg68icDFGk+CEXXiXkgKGzJMBtUVuvdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Muig82Oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CF7C116C6;
	Fri, 13 Feb 2026 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770998512;
	bh=53UIlOOH57Oi25hpAJSpEYDCkMejcnDHh/EgOEa9+uE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Muig82OyvgZ+iyyKU7uAZpv0RML7MYA9CilWjjc8YBYo4Sr+8a18pYUKRI4sW4MpI
	 ZAEF0dUjPPbD5sTMbPbgfgBXWHKSR6BCQRvu1Imuuj+s3oL5dc1A+lep5vQlkNsraw
	 hUr2GQIknTHOchOC7JI7PdRaOYET4QfHqtkXHeyyZXFr/k/FUGlCkQNoyCd/0+4yTj
	 qKFF1XH58KrpM1VdJpEz+5m1uZtjOwtSaCxfSfo0umZ7pRSCWvqOvs31HclhK5cEmi
	 xaLV0/l/9g4v7Tl+EpZUvjiZalfyYKUVZL/+uqwpK33tVcuKXep+lP9GT5hcyrHawl
	 DLgSpVzyp6Wvg==
Message-ID: <69ddd9ac-a12c-4680-9969-d5c45e8e5ffc@kernel.org>
Date: Fri, 13 Feb 2026 17:01:48 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: esd_usb: add endpoint type validation
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: socketcan@esd.eu, "David S . Miller" <davem@davemloft.net>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frank Jungclaus <frank.jungclaus@esd.eu>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260210035929.3490155-1-n7l8m4@u.northwestern.edu>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260210035929.3490155-1-n7l8m4@u.northwestern.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6548-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[northwestern.edu:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[n7l8m4.u.northwestern.edu:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,northwestern.edu:email]
X-Rspamd-Queue-Id: 00CAF137C91
X-Rspamd-Action: no action

On 10/02/2026 at 04:59, Ziyi Guo wrote:
> esd_usb_probe() constructs bulk pipes for two endpoints without
> verifying their transfer types:
> 
>   - usb_rcvbulkpipe(dev->udev, 1) for RX (version reply, async RX data)
>   - usb_sndbulkpipe(dev->udev, 2) for TX (version query, CAN frames)
> 
> A malformed USB device can present these endpoints with transfer types
> that differ from what the driver assumes, triggering the WARNING in
> usb_submit_urb().
> 
> Add usb_check_bulk_endpoints() before the first bulk transfer to verify
> endpoint types, rejecting devices with mismatched descriptors at probe
> time.
> 
> Similar to
> - commit 90b7f2961798 ("net: usb: rtl8150: enable basic endpoint checking")
>   which established the usb_check_bulk_endpoints() validation pattern.
> 
> Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
>  drivers/net/can/usb/esd_usb.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index 8cc924c47042..054ded490eb3 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c
> @@ -1301,6 +1301,10 @@ static int esd_usb_probe(struct usb_interface *intf,
>  	struct esd_usb *dev;
>  	union esd_usb_msg *msg;
>  	int i, err;
> +	static const u8 bulk_ep_addr[] = {
> +		USB_DIR_IN | 1,		/* EP 1 IN  (RX) */
> +		USB_DIR_OUT | 2,	/* EP 2 OUT (TX) */
> +		0};

Instead of using magic numbers with comments declare a macro:

#define ESD_USB_EP_IN 1
#define ESD_USB_EP_OUT 2

and use it throughout the driver.

>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  	if (!dev) {
> @@ -1320,6 +1324,13 @@ static int esd_usb_probe(struct usb_interface *intf,
>  		goto free_msg;
>  	}
>  
> +	/* Verify that the required bulk endpoints are present */
> +	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr)) {
> +		dev_err(&intf->dev, "Missing or invalid bulk endpoints\n");
> +		err = -ENODEV;
> +		goto free_msg;
> +	}

usb_check_bulk_endpoints() calls usb_find_endpoint(). Here, I would
rather just call usb_find_endpoint() and use the found endpoints. Like
this:

------------8<------------
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 8cc924c47042b..d2261046be91d 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -272,6 +272,9 @@ struct esd_usb {
 
 	struct usb_anchor rx_submitted;
 
+	unsigned int rx_pipe;
+	unsigned int tx_pipe;
+
 	int net_count;
 	u32 version;
 	int rxinitdone;
@@ -537,7 +540,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 	}
 
 resubmit_urb:
-	usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
+	usb_fill_bulk_urb(urb, dev->udev, dev->rx_pipe,
 			  urb->transfer_buffer, ESD_USB_RX_BUFFER_SIZE,
 			  esd_usb_read_bulk_callback, dev);
 
@@ -626,9 +629,7 @@ static int esd_usb_send_msg(struct esd_usb *dev, union esd_usb_msg *msg)
 {
 	int actual_length;
 
-	return usb_bulk_msg(dev->udev,
-			    usb_sndbulkpipe(dev->udev, 2),
-			    msg,
+	return usb_bulk_msg(dev->udev, dev->tx_pipe, msg,
 			    msg->hdr.len * sizeof(u32), /* convert to # of bytes */
 			    &actual_length,
 			    1000);
@@ -639,12 +640,8 @@ static int esd_usb_wait_msg(struct esd_usb *dev,
 {
 	int actual_length;
 
-	return usb_bulk_msg(dev->udev,
-			    usb_rcvbulkpipe(dev->udev, 1),
-			    msg,
-			    sizeof(*msg),
-			    &actual_length,
-			    1000);
+	return usb_bulk_msg(dev->udev, dev->rx_pipe, msg,
+			    sizeof(*msg), &actual_length, 1000);
 }
 
 static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
@@ -677,8 +674,7 @@ static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
 
 		urb->transfer_dma = buf_dma;
 
-		usb_fill_bulk_urb(urb, dev->udev,
-				  usb_rcvbulkpipe(dev->udev, 1),
+		usb_fill_bulk_urb(urb, dev->udev, dev->tx_pipe,
 				  buf, ESD_USB_RX_BUFFER_SIZE,
 				  esd_usb_read_bulk_callback, dev);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
@@ -903,7 +899,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	/* hnd must not be 0 - MSB is stripped in txdone handling */
 	msg->tx.hnd = BIT(31) | i; /* returned in TX done message */
 
-	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
+	usb_fill_bulk_urb(urb, dev->udev, dev->tx_pipe, buf,
 			  msg->hdr.len * sizeof(u32), /* convert to # of bytes */
 			  esd_usb_write_bulk_callback, context);
 
@@ -1298,10 +1294,16 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 static int esd_usb_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	struct esd_usb *dev;
 	union esd_usb_msg *msg;
 	int i, err;
 
+	err = usb_find_common_endpoints(intf->cur_altsetting, &ep_in, &ep_out,
+					NULL, NULL);
+	if (err)
+		return err;
+
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
 		err = -ENOMEM;
@@ -1309,6 +1311,8 @@ static int esd_usb_probe(struct usb_interface *intf,
 	}
 
 	dev->udev = interface_to_usbdev(intf);
+	dev->rx_pipe = usb_rcvbulkpipe(dev->udev, ep_in->bEndpointAddress);
+	dev->tx_pipe = usb_sndbulkpipe(dev->udev, ep_out->bEndpointAddress);
 
 	init_usb_anchor(&dev->rx_submitted);
 
------------>8------------

This also enforce that we are using existing endpoints while being
more concise.


Yours sincerely,
Vincent Mailhol

