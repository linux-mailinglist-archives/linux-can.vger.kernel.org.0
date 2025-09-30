Return-Path: <linux-can+bounces-5059-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F6EBAB21E
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 05:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814EC7A4285
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 03:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AADC1F4CBB;
	Tue, 30 Sep 2025 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="SlilKR8i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k6WEIS8t"
X-Original-To: linux-can@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A8145B16;
	Tue, 30 Sep 2025 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201772; cv=none; b=gr7TMQNsC0njGw8mtL3m5baB8pj7Mp2rl8U/6j0T8B9h25DN6r04HvznyDubrCsyBBULfPZ58vySGPyambvrwfN7NMPxoZ+vJZflAirsEdwEEmy3Y/TfDTChSXRkEhHKW9BSWfIgN9tpLzBQroivbq4+o45zKYvfPDEaA5nrII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201772; c=relaxed/simple;
	bh=cTsKlF/UKCf3NXGgvlXE4tWi7/s2EpZ/wRaofY/uOIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrQuriRS8aq7xue+Q7VIxn1bBkBV+cd4YSzLPoc+Ou0I+eesHDgd0efv876y4nPxbrioQSTEtOzlig5ICuG48NW6YcNmZhmQ4j+u45x6wjAvwg8mwXcbrc0cazNkaJCujzrytsja5jJyRjE7lLLk4GyySR1e191j+CpiPV+MGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=SlilKR8i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k6WEIS8t; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97DB57A008A;
	Mon, 29 Sep 2025 23:09:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 29 Sep 2025 23:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1759201769; x=1759288169; bh=MyjvQ5+86g
	MKIBt8Bd75v3GXYl5r02qUhj02YOsrjwg=; b=SlilKR8i9hp5huuwTOHwxOv1Zn
	zkxjBfj4jLXgZOVsrMX3yEDHipmY5Sm5VX3UUeurp5qcyjJTwluItCyaidg60myg
	PCaRKU+BGfc6CvqB2LCwlo4wWnS2VlmsOcVMH4grRZMCG4HmPFSLNX4xghjgnS8n
	uNnhW9JzJih8SZ4o1jI5erd/eIrT0Y4wm6c0/kVj6Og3PRkNMaNSXgnmtROJMDZJ
	wm3VN6G72KuiCIF0suVoovTTYOGttp5NGM3cTeOfkoj5upbzErxmerQtD7gNqLaq
	644teUuho5GCivYIfN48NDRRPzinh010YiMDNuDsSP/zzWPPL8ee9vQWvXfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759201769; x=
	1759288169; bh=MyjvQ5+86gMKIBt8Bd75v3GXYl5r02qUhj02YOsrjwg=; b=k
	6WEIS8ts6sexoaM8eUE3zixwDLv4O1QI3/oM3TXe78xWJoSjzeSLU6PX0p2al6+y
	D5B2ySTypCp990ZcnRHolMNE9LLFt4pi+fN0uE5JyQXCrUq4DV5SXwaTA+/ScwVW
	HGKz28/JrFK6eYGq4Dkkhxxg+cz+5yHoMa6oJ5QAuYqDVjycDBg18dM+sY8A3VTw
	umAV3vWokzst/zz0c3aAS03KzE2UBFtw5vRwdAuCujKXu98DvyRN7FtVfSYCop7r
	BlEQKlCYmwhFSm7DsISNupZqYYR7gHMMLZVaSg/2TB4OphcWlYmD5pqmOG2sCo5H
	hTbgcJex/JpByTVL3RhGw==
X-ME-Sender: <xms:6EnbaH0CXrmgqnKJSqUd0yZ3NY8PCc9o3XqJY2nZgP-rubNLKRu-Sw>
    <xme:6EnbaB8wZAuC3zhuk_at4IAH3gTZf1H0L-NJMCpfUDRdQDPG0lQhU9x7M7l9JVa6Y
    gezLZMlMbBeOoHm4WAqIwsTtJAIfJHepEChSsZu1QBwbZgCuOMILo0>
X-ME-Received: <xmr:6EnbaE5yQ-spzobuIimVAVim_y4IjekMHFHl-HVrEk3-vJa4AzBJnN8zvMFv4HMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvegvlhgvshht
    vgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeeftdetudehtdehgfelfefhfeffffffvedvtdetfedvveevhfeffeelhfeh
    veegtdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihusegt
    ohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepmhhklhesphgvnhhguhhtrhhonhhigidruggvpdhr
    tghpthhtohepmhgrihhlhhholhdrvhhinhgtvghnthesfigrnhgrughoohdrfhhrpdhrtg
    hpthhtohepmhgrgiesshgthhhnvghiuggvrhhsohhfthdrnhgvthdprhgtphhtthhopehh
    vghnrhhikhessghrihigrghnuggvrhhsvghnrdgukhdprhgtphhtthhopeifghesghhrrg
    hnuggvghhgvghrrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehguhhsthgrvhhorghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqtggrnhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6EnbaBsqg4Xnf16fO_8dNLvjCaNKpX15uzcf7FbCTrRgZbpMIecScA>
    <xmx:6EnbaO1o4rM-9O68cWKV89sMVkeFRsMarviRUA2n7K7u5cDD8mV7QQ>
    <xmx:6EnbaCrY1XSBcmWoK1VTC8bHnb5LiZ_umngjtYt8fZL8r_Hq8sHS1g>
    <xmx:6EnbaGJchdiDCHxfZYcTxmGzcz0PCjXupwclOLqK9dEiOoger6UHSQ>
    <xmx:6UnbaD3w90oqyUMtmougFz1lvsYYIBa1ps7GcKu6JZrzwviv_K9NDjcJ>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 23:09:25 -0400 (EDT)
Message-ID: <69d8d61e-1b87-42a6-a70c-52d40546e0e5@coelacanthus.name>
Date: Tue, 30 Sep 2025 11:09:24 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/can/gs_usb: increase max interface to U8_MAX
Content-Language: en-GB-large
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Maximilian Schneider <max@schneidersoft.net>,
 Henrik Brix Andersen <henrik@brixandersen.dk>,
 Wolfgang Grandegger <wg@grandegger.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Runcheng Lu <runcheng.lu@hpmicro.com>
References: <20250930-gs-usb-max-if-v2-1-2cf9a44e6861@coelacanthus.name>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <20250930-gs-usb-max-if-v2-1-2cf9a44e6861@coelacanthus.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-30 11:00, Celeste Liu wrote:
> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
> converter[1]. The original developers may have only 3 intefaces device to
> test so they write 3 here and wait for future change.
> 
> During the HSCanT development, we actually used 4 interfaces, so the
> limitation of 3 is not enough now. But just increase one is not
> future-proofed. Since the channel type in gs_host_frame is u8, just
> increase interface number limit to max size of u8 safely.
> 
> [1]: https://github.com/cherry-embedded/HSCanT-hardware
> 
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>

Sorry, I add Cc stable in wrong place (cover letter instead of patch), so only copy
sent to stable maillist but without tag, I have sent v3 to fix it.

> ---
> Changes in v2:
> - Use flexible array member instead of fixed array.
> - Link to v1: https://lore.kernel.org/r/20250929-gs-usb-max-if-v1-1-e41b5c09133a@coelacanthus.name
> ---
>  drivers/net/can/usb/gs_usb.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index c9482d6e947b0c7b033dc4f0c35f5b111e1bfd92..69b068c8fa8fbab42337e2b0a3d0860ac678c792 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -289,11 +289,6 @@ struct gs_host_frame {
>  #define GS_MAX_RX_URBS 30
>  #define GS_NAPI_WEIGHT 32
>  
> -/* Maximum number of interfaces the driver supports per device.
> - * Current hardware only supports 3 interfaces. The future may vary.
> - */
> -#define GS_MAX_INTF 3
> -
>  struct gs_tx_context {
>  	struct gs_can *dev;
>  	unsigned int echo_id;
> @@ -324,7 +319,6 @@ struct gs_can {
>  
>  /* usb interface struct */
>  struct gs_usb {
> -	struct gs_can *canch[GS_MAX_INTF];
>  	struct usb_anchor rx_submitted;
>  	struct usb_device *udev;
>  
> @@ -336,9 +330,11 @@ struct gs_usb {
>  
>  	unsigned int hf_size_rx;
>  	u8 active_channels;
> +	u8 channel_cnt;
>  
>  	unsigned int pipe_in;
>  	unsigned int pipe_out;
> +	struct gs_can *canch[] __counted_by(channel_cnt);
>  };
>  
>  /* 'allocate' a tx context.
> @@ -599,7 +595,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  	}
>  
>  	/* device reports out of range channel id */
> -	if (hf->channel >= GS_MAX_INTF)
> +	if (hf->channel >= parent->channel_cnt)
>  		goto device_detach;
>  
>  	dev = parent->canch[hf->channel];
> @@ -699,7 +695,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  	/* USB failure take down all interfaces */
>  	if (rc == -ENODEV) {
>  device_detach:
> -		for (rc = 0; rc < GS_MAX_INTF; rc++) {
> +		for (rc = 0; rc < parent->channel_cnt; rc++) {
>  			if (parent->canch[rc])
>  				netif_device_detach(parent->canch[rc]->netdev);
>  		}
> @@ -1460,17 +1456,19 @@ static int gs_usb_probe(struct usb_interface *intf,
>  	icount = dconf.icount + 1;
>  	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
>  
> -	if (icount > GS_MAX_INTF) {
> +	if (icount > type_max(typeof(parent->channel_cnt))) {
>  		dev_err(&intf->dev,
>  			"Driver cannot handle more that %u CAN interfaces\n",
> -			GS_MAX_INTF);
> +			type_max(typeof(parent->channel_cnt)));
>  		return -EINVAL;
>  	}
>  
> -	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
> +	parent = kzalloc(struct_size(parent, canch, icount), GFP_KERNEL);
>  	if (!parent)
>  		return -ENOMEM;
>  
> +	parent->channel_cnt = icount;
> +
>  	init_usb_anchor(&parent->rx_submitted);
>  
>  	usb_set_intfdata(intf, parent);
> @@ -1531,7 +1529,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
>  		return;
>  	}
>  
> -	for (i = 0; i < GS_MAX_INTF; i++)
> +	for (i = 0; i < parent->channel_cnt; i++)
>  		if (parent->canch[i])
>  			gs_destroy_candev(parent->canch[i]);
>  
> 
> ---
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
> change-id: 20250929-gs-usb-max-if-a304c83243e5
> 
> Best regards,


