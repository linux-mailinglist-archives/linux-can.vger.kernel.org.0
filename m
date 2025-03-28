Return-Path: <linux-can+bounces-3244-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A32A7454B
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 09:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3354E3B1F86
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D4211A35;
	Fri, 28 Mar 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Wsqf2ZSb"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A3153BE8;
	Fri, 28 Mar 2025 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150164; cv=none; b=Eg5af1o8ZJBxc6A9byy0NsaFXS90kF5jrP6Ug9sY291a4DCMcvAG3nV3VQCahidAJQ+7Zm0LsOEkEGyi9EVrFIb8Xk/fHI4iD532GZ7x18xrZ5KMcppUByuIbbc7Dic3SFH+KUBl2pSV+JM+k/gej0LDGuGt/iIvP44ZXlRV+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150164; c=relaxed/simple;
	bh=F6QV+Madps5rfli4msND+iUdjd3G1SNG3npgXMxCHKk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qOMTiOo1qkEhFqBZk4mC2F/ovxUbJcRQa/Z/UoptYP5fvclVyv9h4+UM40AyZ9uzzui72Yjzja5N6FDGBDbFov5w1be3DYPa4jLQT2DrHlHx7iHhxppNV7cyMnK+ZlvHiUPlWzNc+KFpyVA46jhNDIffyElDwt6lst0Str8PpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Wsqf2ZSb; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y4ytt6H5o4o0iy4yxtRjTi; Fri, 28 Mar 2025 09:22:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743150154;
	bh=DTDbD/ooJMwFg/YbtZABbAe7VxGrq0KHlq70LD0SD5E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=Wsqf2ZSbPHdpjIHOgoN2/945gS2i1us5saPSWaHtY66By+j39yPEAshlAIHQ+TkGf
	 faxd2iqsEp/WH9p5lUHFiO5zzNTz+YjU2KoFQsIIiR+jZB2uCVEPSRBErgThgbcSg7
	 zsDzA2RqhqWR5/0HN/xv3W+ks4SvBv8W08FOPQOlvxBdkOgU3AlxWY7VAPsFT8+EAa
	 ey+Wvh3kbID70huZ4lIcg8rg9W5uRd619WDsJx/pqBeOsP0FuuciZgdy+JjXFeZWsb
	 8r8r7sJgNeBZn/kbU5a6M79Th4FvI3ZrRvfUCm+Vna9uK1NxZ+qUJHBhXNwGrwPd7B
	 mPiIU1dzXLK9w==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 09:22:34 +0100
X-ME-IP: 124.33.176.97
Message-ID: <cd6bab58-592b-43de-a0c5-b1c01d99e1c2@wanadoo.fr>
Date: Fri, 28 Mar 2025 17:22:22 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v2] phy: can-transceiver: Re-instate "mux-states" property
 presence check
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh@kernel.org>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Peter Rosin <peda@axentia.se>,
 Aswath Govindraju <a-govindraju@ti.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
References: <3d7e0d723908284e8cf06ad1f7950c03173178f3.1742483710.git.geert+renesas@glider.be>
 <7805e0db-7c17-438d-9985-f4feec644da6@wanadoo.fr>
Content-Language: en-US
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
In-Reply-To: <7805e0db-7c17-438d-9985-f4feec644da6@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/03/2025 at 13:18, Vincent Mailhol wrote:
> On 21/03/2025 at 00:15, Geert Uytterhoeven wrote:
>> On the Renesas Gray Hawk Single development board:
>>
>>     can-transceiver-phy can-phy0: /can-phy0: failed to get mux-state (0)
>>
>> "mux-states" is an optional property for CAN transceivers.  However,
>> mux_get() always prints an error message in case of an error, including
>> when the property is not present, confusing the user.
>>
>> Fix this by re-instating the property presence check (this time using
>> the proper API) in a wrapper around devm_mux_state_get().  When the
>> multiplexer subsystem gains support for optional muxes, the wrapper can
>> just be removed.
>>
>> In addition, propagate all real errors upstream, instead of ignoring
>> them.
> 
> I would like to hear Rob's opinion on this. In d02dfd4ceb2e9f34 Rob
> purposely changed the function to ignore errors other than EPROBE_DEFER.
> 
> Right now, I do not see a reason not to propagate the other errors, so
> I am in favor of this roll back. But maybe we are missing something?
> 
> Otherwise, the patch looks good to me. Nice improvement over the v1. I
> will wait for Rob's comment to give my review tag.

One week has gone, and we did not hear back. So let's assume it is OK.

>> Fixes: d02dfd4ceb2e9f34 ("phy: can-transceiver: Drop unnecessary "mux-states" property presence check")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

(...)

Yours sincerely,
Vincent Mailhol

