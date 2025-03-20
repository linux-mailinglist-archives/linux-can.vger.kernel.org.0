Return-Path: <linux-can+bounces-3184-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03642A6A516
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 12:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7176F17DA40
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B5A21B9FC;
	Thu, 20 Mar 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mKigk8MQ"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-74.smtpout.orange.fr [193.252.22.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800879C4;
	Thu, 20 Mar 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470726; cv=none; b=K6SBLs5zV/suwfIa4JMn1OtM7gLVjq/PPy7lcRg7I5f4h2hdzYvl+7KOfrSKj2xdYnV34wuBziswn7Vo40K/+WoVXXvqPs1PtDFIvBDbtxslHyB2Ob+X6gd3UTE1yiE9m4YavPZkh3LV4jYZKS/xm/cmm9JTiahl3odf2/1OzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470726; c=relaxed/simple;
	bh=sqWe3Yev3PzpdiPsJpDcuVLTdKO468pWXUX9p7X7Sq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDeCYmfphaTDsNDO/7WlRDn3WNdIhejqaYKX3Tv1pHqF16akWg0GBQ9YDdjRBL2Se3jaqaLfWr81khMqSYoK0ueqPUXwrHyGbgic1TIlNoCe9bHx5hvj3MtiWZv/YQJ9TPkACn4RZy3US84U5ZtDU5zqNzusWmlKd1g5f5YHDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mKigk8MQ; arc=none smtp.client-ip=193.252.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id vE5NtqnW0l2qkvE5StwZBJ; Thu, 20 Mar 2025 12:29:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742470167;
	bh=HtkbDjg5JYzHIlz/GhvgabNqyIBX/GomSRMi/5wmM70=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mKigk8MQqTSpH+DIMTQgPjZ8ir08SHXMunE3l6aJFhCLo/C2NfZfcRSThm/XplKeR
	 sYUKFJijfvEtf4qBY2pP5xldRNPytRu/w+bekSg3tjQzypZyVTSbNc/uGqqeERxxxu
	 VcXE4NxEMKtHNUQiCeKv48JhsitqduHAplFOZlbKaWM7KWHU/LzwIIsVY+a46IYz2w
	 zxPEp32PGkfVBu0Y04qXNrf37bqpoEshtIX5xQhK2vkDh23pU2bdPh/zJFUPb5KN4a
	 CgkfPEtF666z6frBEG6jVvVcp/zvgaBI9vP7fzynzXqATSuJhP7VLV2e0vixS1SZlU
	 +WnH0W4V8JuQg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 20 Mar 2025 12:29:27 +0100
X-ME-IP: 124.33.176.97
Message-ID: <864ae6d6-4d60-4175-86a9-039b75440330@wanadoo.fr>
Date: Thu, 20 Mar 2025 20:29:16 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: can-transceiver: Re-instate "mux-states" property
 presence check
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Peter Rosin <peda@axentia.se>, Aswath Govindraju <a-govindraju@ti.com>
References: <6bcfde63b3a6b25640a56be2e24a357e41f8400f.1742390569.git.geert+renesas@glider.be>
 <9875d99a-4e16-4f0e-9249-69f0acc4c890@wanadoo.fr>
 <CAMuHMdVCmchuN1LyHGoE6A0TEpc9R1unXi2KNYO94cmT1WwOHA@mail.gmail.com>
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
In-Reply-To: <CAMuHMdVCmchuN1LyHGoE6A0TEpc9R1unXi2KNYO94cmT1WwOHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2025 at 19:25, Geert Uytterhoeven wrote:
> Hi Vincent,

(...)

>> On 19/03/2025 at 22:27, Geert Uytterhoeven wrote:
>>> On the Renesas Gray Hawk Single development board:
>>>
>>>     can-transceiver-phy can-phy0: /can-phy0: failed to get mux-state (0)
>>>
>>> "mux-states" is an optional property for CAN transceivers.  However,
>>> mux_get() always prints an error message in case of an error, including
>>> when the property is not present, confusing the user.
>>
>> Hmmm, I understand why you are doing this patch. But on the long term,
>> wouldn't it make more sense to have a devm_mux_state_get_optional()? Or
>> maybe add a property somewhere to inform devm_mux_state_get() that this
>> is optional?
>>
>> Regardless, just see this as an open question. I am OK with the approach
>> of your patch.
> 
> Alternatively, we can be proactive and add a temporary local wrapper:
> 
>     /* Dummy wrapper until optional muxes are supported */
>     static inline struct mux_state *
>     devm_mux_state_get_optional(struct device *dev, const char *mux_name)
>     {
>             if (!of_property_present(dev->of_node, "mux-states"))
>                     return NULL;
> 
>             return devm_mux_state_get(dev, mux_name);
>     }
> 
> and call that instead?  Then the probe function needs no future changes
> when the real devm_mux_state_get_optional() arrives.

This looks like a more elegant and more long term solution!

Yours sincerely,
Vincent Mailhol


