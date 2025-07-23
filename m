Return-Path: <linux-can+bounces-4062-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB88B0F20D
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 14:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D943BC041
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D3A1D63C5;
	Wed, 23 Jul 2025 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lEHySWc9"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7416FF37
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273068; cv=none; b=BgDQBK2Sk4YM4+tatBRRu8azvX1yRzmO5bg5XKj+jYOcyGwSdSDWWk0DEAfu5wmjITXjwWoKpIkHbDrhuHoO7vBLYHe1MYCMYqRL/L+DDLWJlQhnDVATF8hix1gD7+vRwn2EjUBQxGytTLWeAFyAkbO90n1C5vGp2imHVKUEv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273068; c=relaxed/simple;
	bh=vh1I3/K9vr3q9fnT0IDElmE5XpPB3aqSy4pvEDr4IY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XF0wwrruYSY1ByjohqbrUz8tiGlupiTH+Jr54pSVU8wFyIaactR1a/S3u5gi5Cb9Vcs7Jr7PvQat0ZAvnQnwBidU1WwUMXRXb89HqQsYMpZQh7pb6AmtAEzar/8jpWFmEpZWEO+tEQ8Tx/e/+nR3JD266uDMX+qktSmhQW+cZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lEHySWc9; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eYPkuTY7LXbdFeYPlux7wp; Wed, 23 Jul 2025 14:17:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753273063;
	bh=4/jE4c9wc7/LxvNAt/czgq/BtEXwxoCfuWNAQT6UnQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lEHySWc9LVS7cvfVjsXkx7VL189AkoZpbxXWm1ZrWTTH+FjBdzc+IbdKIvrcRG4bn
	 K9AB8h+4YNl7gtXA0gTZgufBe6Spnok/a9RD+ijVxyDyEVjsvv7yRotNiTFqL9vbDt
	 U59Fvp0yURIkpeW7d/x0hjzsvtf40nKMBeBaY17Mp9Aia6CYvKkkU6SlRvEsigwN0f
	 ExB6cbGUaBX/iKJACNCeQlLrEdq1hUHYSy+j2Op1r2Es44/4c0xFEfODlZkuT+Wcq8
	 WVQFHE6HLqxeeBDheJyFJlWJUHbpo1q0t72Znn8ox0kIKtwJjLhY6Un9IOWnjp+tkm
	 0E4tS1lokSIPg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jul 2025 14:17:43 +0200
X-ME-IP: 124.33.176.97
Message-ID: <ba6700b9-a2e4-44a3-b64c-91826188e845@wanadoo.fr>
Date: Wed, 23 Jul 2025 21:17:40 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] can: kvaser_pciefd: Store the different firmware
 version components in a struct
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250723083236.9-1-extja@kvaser.com>
 <20250723083236.9-5-extja@kvaser.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250723083236.9-5-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 at 17:32, Jimmy Assarsson wrote:
> Store firmware version in kvaser_pciefd_fw_version struct, specifying the
> different components of the version number.
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/kvaser_pciefd.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index f2722473b865..eba19819ca43 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -325,6 +325,12 @@ struct kvaser_pciefd_driver_data {
>  	const struct kvaser_pciefd_dev_ops *ops;
>  };
>  
> +struct kvaser_pciefd_fw_version {
> +	u8 major;
> +	u8 minor;
> +	u16 build;
> +};
> +
>  static const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {
>  	.serdes = 0x1000,
>  	.pci_ien = 0x50,
> @@ -437,6 +443,7 @@ struct kvaser_pciefd {
>  	u32 bus_freq;
>  	u32 freq;
>  	u32 freq_to_ticks_div;
> +	struct kvaser_pciefd_fw_version fw_version;
>  };
>  
>  struct kvaser_pciefd_rx_packet {
> @@ -1207,14 +1214,16 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
>  	u32 version, srb_status, build;
>  
>  	version = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_VERSION_REG);
> +	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
>  	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
>  				FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_MASK, version));
> -
> -	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
> -	dev_dbg(&pcie->pci->dev, "Version %lu.%lu.%lu\n",
> -		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version),
> -		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version),
> -		FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build));
> +	pcie->fw_version.major = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version);
> +	pcie->fw_version.minor = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version);
> +	pcie->fw_version.build = FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build);
> +	dev_dbg(&pcie->pci->dev, "Version %u.%u.%u\n",
> +		pcie->fw_version.major,
> +		pcie->fw_version.minor,
> +		pcie->fw_version.build);

At the end of this series, the firmware version will be available through the
devlink interface, so this debug message loses it purpose. If you do not mind,
better to remove that dev_dbg().

>  	srb_status = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_STAT_REG);
>  	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {

Yours sincerely,
Vincent Mailhol


