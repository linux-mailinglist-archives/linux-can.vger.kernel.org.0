Return-Path: <linux-can+bounces-864-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B100E91BDD4
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 13:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F15285C34
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C427F158213;
	Fri, 28 Jun 2024 11:50:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from sxb1plsmtpa01-07.prod.sxb1.secureserver.net (sxb1plsmtpa01-07.prod.sxb1.secureserver.net [92.204.81.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F40158855
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575428; cv=none; b=K44OBt+HvIx1yfP/5jsJfoy1wJpOTr09dlEZkEHeIuhQqZZw9ZKSp4JmCCA84xTvmF03Krwls3IxGq6X2H3uZe8Ms9HZxwyHl9DJ4udEpPDrtUiR1C7Wa1oCYLBvyOsretCQDkKmtAGTICEgJU0VCVpP8s5/7EfMqt+a+71Au8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575428; c=relaxed/simple;
	bh=8NuJ8s+9yR3JoeVe52n6M2u1rpwEkESB5TKiiUhJKss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAn/yUUD+kFVkanzO7tAUJN8+3KFavSQFjTCeDIZx71BURz6yMD3Wt8nO9PVwx5uWK5Fb0ogGzVLb5HMns+Wxz5AJ/dpvZ+ACIoe39UKuTY9rWCyDtX1m0QeTvBCQgciTdG19l/H4ztbzAFKFfLq8cRPbX1NYvbOGfm60Xyi6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xylanta.com; spf=pass smtp.mailfrom=xylanta.com; arc=none smtp.client-ip=92.204.81.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xylanta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xylanta.com
Received: from [192.168.1.47] ([81.79.16.132])
	by :SMTPAUTH: with ESMTPSA
	id N7aAstylKyEmvN7aEs8nZG; Fri, 28 Jun 2024 02:07:55 -0700
X-CMAE-Analysis: v=2.4 cv=a/v79lSF c=1 sm=1 tr=0 ts=667e7d6b
 a=j/c4x+jxkjSfmXrxZ6rEcQ==:117 a=j/c4x+jxkjSfmXrxZ6rEcQ==:17
 a=IkcTkHD0fZMA:10 a=hRiF0RuuAAAA:8 a=c8SnOe5329Iw8baMLMEA:9 a=QEXdDO2ut3YA:10
 a=f8KmGVCobydkL2cZcAgM:22
X-SECURESERVER-ACCT: andy@xylanta.com
Message-ID: <02268a29-a390-4cfa-9ab4-6cceea3bf2e1@xylanta.com>
Date: Fri, 28 Jun 2024 10:07:51 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: andy@xylanta.com
Subject: Re: [PATCH] can: gs_usb: add VID/PID for Xylanta SAINT3 product
 family
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Ken Aitchison <ken@xylanta.com>
References: <20240625140353.769373-1-mkl@pengutronix.de>
Content-Language: en-US
From: Andy Jackson <andy@xylanta.com>
Organization: Xylanta Ltd
In-Reply-To: <20240625140353.769373-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHVFsaS2n4pX+jfDiq2FwtTRQhdDR0hTLxp9I4h+GS8g3VPx11hvy5ePmRDkyclnEIfn26NZLaZujdmWcyybbmL2qdjDHZPZMSPfgd7dzUQJMhlaNx/j
 jn1UdHhXxyBLQSKZEeCwDrUcvUtExRZ3LARljXcNnZIEUTJy0OJqwdUVW9tR3PuhtPtDEwJqcgXlbQqjnPUEFKdWGdj/sLM3ZZRQ13zR+PYoXG/EUXfLpdbp
 cisU2wnIiz0SHAxY9kmryGBlxylTWU2zZ7k/tdugm9NCNNfbmi1X4DZNSPGeZ+JE6SbP/zRXdb2wM61ccH4QbA==

On 25/06/2024 15:03, Marc Kleine-Budde wrote:
> Add support for the Xylanta SAINT3 product family.
>
> Cc: Andy Jackson <andy@xylanta.com>
> Cc: Ken Aitchison <ken@xylanta.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/usb/gs_usb.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 65c962f76898..340297e3bec7 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -40,6 +40,9 @@
>   #define USB_ABE_CANDEBUGGER_FD_VENDOR_ID 0x16d0
>   #define USB_ABE_CANDEBUGGER_FD_PRODUCT_ID 0x10b8
>   
> +#define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
> +#define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
> +
>   #define GS_USB_ENDPOINT_IN 1
>   #define GS_USB_ENDPOINT_OUT 2
>   
> @@ -1530,6 +1533,8 @@ static const struct usb_device_id gs_usb_table[] = {
>   				      USB_CES_CANEXT_FD_PRODUCT_ID, 0) },
>   	{ USB_DEVICE_INTERFACE_NUMBER(USB_ABE_CANDEBUGGER_FD_VENDOR_ID,
>   				      USB_ABE_CANDEBUGGER_FD_PRODUCT_ID, 0) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(USB_XYLANTA_SAINT3_VENDOR_ID,
> +				      USB_XYLANTA_SAINT3_PRODUCT_ID, 0) },
>   	{} /* Terminating entry */
>   };

Tested-by: Andy Jackson <andy@xylanta.com>



