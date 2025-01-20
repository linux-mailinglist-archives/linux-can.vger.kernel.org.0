Return-Path: <linux-can+bounces-2664-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5BA16E42
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 15:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6B61889AA3
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678361E515;
	Mon, 20 Jan 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="aHSTfw2D"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A633E7
	for <linux-can@vger.kernel.org>; Mon, 20 Jan 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382636; cv=none; b=r7slWa6j9KuqSkzxLhBO1ml2Z4c3u3IJv2TlAf2xrQmsJwF3poIys4Cy2IHvdq0rfwv2Tu2dt6li45Y0lg167RlXJhJZX4w9JXc6Xp3REIRaJKDRO+k0QucKHVQ/0T0eM0FbhEN6ak/zlz3Zz5rs1nAtNO/bNPrY9tZRCMA44Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382636; c=relaxed/simple;
	bh=P1VOji3K2AyRL9dY8Cafk0yWVkjtCke8/naH7W/C1S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZwTeVh+F4A397FseZ1yOI2frMBtJAndI3T1aFEQ4l+BS87c2Yq0iuz8ysJzU4ZfFpgL/CMmi9F5lwyg+jAs70sRlkymvO9i5ZXr57ZxYlpDFHj6GMt1dI0Kkm7KlK7ogEQaSAzApeZrVHSz+bYJCgRZIADlMDoI/MM+iKr/Hy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=aHSTfw2D; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ip/c+iImzG1LBGj3hj/whexRyXTI800XkCHSFXo66e8=; b=aHSTfw2Dyzua077YGuJVZqr19Q
	tc5J+F4H+d3KgkWjNJrCg53mQyqlLlqy5TBVpT83SQws5G5545+YA7erz0PCaWHSj8+257ADQSKNd
	3mW8N3+hpNb/XsMKFUTwSnY1yzAPlPRIqdsFgWdC74fYjEVO6tkLccDqT2oFMRkaJgo6jH81z7Mvb
	5Oh6G5W/b9cMsjj7gmSxzuZ9Rs7chL8LSE9u0nJppWuKD+PoSIILSnA8wCzg6+1d/WQgYM2o4XEHg
	Qydjqf0BPeAp7Zz5VzJbQT9TeFpwsvcvjIOaX7RK7rS26pOCkZm2U2ZUQengoWZUnDWW+S41jQ8I2
	qUamhtEA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <sean@geanix.com>)
	id 1tZsJq-0007s3-03;
	Mon, 20 Jan 2025 14:59:58 +0100
Received: from [2a06:4004:10df:0:4815:1c2a:6b8:fdc6] (helo=Seans-MBP.snzone.dk)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tZsJp-000A5e-2R;
	Mon, 20 Jan 2025 14:59:57 +0100
Date: Mon, 20 Jan 2025 14:59:57 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Henrik Brix Andersen <henrik@brixandersen.dk>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: gs_usb: add VID/PID for the CANnectivity firmware
Message-ID: <4p7ik4wux4ecdsml4h7cm3rjs7mdk7agji5m37nb2fo5h6wu5r@o7jfeujvqhoc>
References: <20250120133827.668977-1-henrik@brixandersen.dk>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250120133827.668977-1-henrik@brixandersen.dk>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 1.0.7/27524/Mon Jan 20 10:37:47 2025)

On Mon, Jan 20, 2025 at 01:37:59PM +0100, Henrik Brix Andersen wrote:
> Add USB VID/PID for the CANnectivity USB to CAN adapter firmware.
> 
> Signed-off-by: Henrik Brix Andersen <henrik@brixandersen.dk>

Tested-by: Sean Nyekjaer <sean@geanix.com>

> ---
>  drivers/net/can/usb/gs_usb.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index b6f4de375df7..3ccac6781b98 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -43,6 +43,9 @@
>  #define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
>  #define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
>  
> +#define USB_CANNECTIVITY_VENDOR_ID 0x1209
> +#define USB_CANNECTIVITY_PRODUCT_ID 0xca01
> +
>  /* Timestamp 32 bit timer runs at 1 MHz (1 µs tick). Worker accounts
>   * for timer overflow (will be after ~71 minutes)
>   */
> @@ -1546,6 +1549,8 @@ static const struct usb_device_id gs_usb_table[] = {
>  				      USB_ABE_CANDEBUGGER_FD_PRODUCT_ID, 0) },
>  	{ USB_DEVICE_INTERFACE_NUMBER(USB_XYLANTA_SAINT3_VENDOR_ID,
>  				      USB_XYLANTA_SAINT3_PRODUCT_ID, 0) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(USB_CANNECTIVITY_VENDOR_ID,
> +				      USB_CANNECTIVITY_PRODUCT_ID, 0) },
>  	{} /* Terminating entry */
>  };
>  
> -- 
> 2.43.0
> 
> 

