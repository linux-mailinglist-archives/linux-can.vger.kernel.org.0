Return-Path: <linux-can+bounces-3276-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D237AA74BB1
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 14:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8EC3B4EEA
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3E321B9DA;
	Fri, 28 Mar 2025 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Xrcc0ULF"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FBF21B918;
	Fri, 28 Mar 2025 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169342; cv=none; b=rTW3kqXCdv6GKWPiFAx/jMYU+bzoJqdkiCYuYVxAGCpMg5wNrSuf0WUdGl2BdKEcnr76hCqH+lbdJ1fYRuEvMJZMLTaxyzaov0kupwb3oCRjt1tCEIbiuLSmRIT9Jl7al6/7bsiaSqx8vPhJjTiB2uF+iXJ7XpNwVjGnaiS/7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169342; c=relaxed/simple;
	bh=GJIvqYo2qpRzu79CzftBIyB8AplHrvhU1wbs8lbUxv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWIQHwvSMn736JNRnduXBPZnzlB1c2NAjVZrswOYXmOG/Md0hJyi69f40+L3gawif/zU1zRn3Z1thS6SgFrXQUvvh0iT+sOt9x91GEb+g7tM2SmWLuZYK2jpl7zH4bAInnV1L10YkipkOITjf883I/wWCVpQazy/TQNH5T24LxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Xrcc0ULF; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y9yIt85jMXDgsy9yMtCDTA; Fri, 28 Mar 2025 14:42:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743169334;
	bh=4VhEea2BiuW9lwnCr91HUSwYdgkMA13aMHe2eYXAoK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Xrcc0ULFXFdU2I9n9JHAkFbiA+wVuoKW9ALehC26/wdK1agdsHF3X71gXNDvRlfN8
	 Y74M9R+Z3W8rXdIT/v/qIbHHo410+ze0+nd9zTRqYQFBx5kV/KWWqGyBQjShoIBTRe
	 8MKYddlXMRTIbk/+h26CLigVakkbOI/t/DGP+lb2GMrvdpS1afX6D8hFpWtTfatxr/
	 /AA3k6pWl4wjyczEzI+cH9ON7xE220jF/6bxwiH2wre5FGEmiZmQ+BUWySMDSZlXZF
	 mIgHa2QF9DBpq8Xu7X3QVTIHU0hSg4eYOnMjg4Xgy5Fs734M0Vv84CM64AnkAqByn1
	 pbZ1Y8dqv5kZA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 14:42:14 +0100
X-ME-IP: 124.33.176.97
Message-ID: <245492b9-a78c-4575-89d1-4181db70cff6@wanadoo.fr>
Date: Fri, 28 Mar 2025 22:42:06 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "biju.das.au" <biju.das.au@gmail.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
 <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
 <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr>
 <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20250328-serious-orange-oarfish-3631f1-mkl@pengutronix.de>
 <CAMuHMdXWDaJx5THFd9NB7VsTjGZgFt8JPGa+WQivSdgYVY1yWg@mail.gmail.com>
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
In-Reply-To: <CAMuHMdXWDaJx5THFd9NB7VsTjGZgFt8JPGa+WQivSdgYVY1yWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2025 at 19:42, Geert Uytterhoeven wrote:
> Hi Marc,
> 
> On Fri, 28 Mar 2025 at 11:20, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> On 28.03.2025 09:51:43, Biju Das wrote:
>>>> Yes, it starts at bit 16, but at which bit does it end?
>>>>
>>>> The GENMASK() helps to document the register names. Of course is works if you replace the FIELD_PREP
>>>> with a left shift, but you are replacing some meaningful information about the register name, register
>>>> start bit and end bit by just a start bit value. See? You just lost the register name and end bit
>>>> info.
>>>>
>>>> FIELD_PREP() is not only about doing the correct shift but also about documenting that you are putting
>>>> the value into a specific register.
>>>>
>>>> When reading:
>>>>
>>>>   FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)
>>>>
>>>> I immediately understand that you are putting the gpriv->channels_mask value into the GERFL_EEF0_7
>>>> register and I can look at the datasheet for details about that GERFL_EEF0_7 if I want to.
>>>
>>> Gen4 has 8 channels (GENMASK(16, 23)
>>> G3E has 6 channels  (GENMASK(16, 21)
>>> V4M has 4 channels  (GENMASK(16, 19)
>>> V3H_2 has 3 channels (GENMASK(16,18)
>>> All other SoCs has 2 channels (GENMASK(16,17)
>>>
>>> So you mean, I should replace RCANFD_GERFL_EEF0_7 with a
>>>
>>> Generic one RCANFD_GERFL_EEF(x) GENMASK(16, 16 + (x) - 1) to handle
>>> this differences
>>>
>>> Where x is the number of supported channels(info->max_channels)
>>>
>>> and then use
>>>
>>> FIELD_PREP(RCANFD_GERFL_EEF(x), gpriv->channels_mask)
>>
>> The mask for FIELD_PREP must be compile time constant.
>>
>> Geert recently posted a series to add non constant helpers:
>>
>> | https://lore.kernel.org/all/1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be/
>>
>> It seems it wasn't applied yet...
> 
> Yeah, people keep on asking for more...
> #perfectistheenemyofgoodenough...

Modifying the most popular headers really takes a lot of effort.
I experienced it first hand when I introduced the GEMASK_U*() fixed
width macros:

https://lore.kernel.org/all/20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr/


Sorry to have been one of those asking for more. My intent was not to
block the effort. Your answers were satisfactory to me.

In my opinion, just adding a rationale to the patch description of:

  - why FIELD_PREP() can not be generalized to non-const mask
  - why the u32_get_bits() & Cie do not work as well

would help to have it move forward. If you resend, I would give you my
support.


Yours sincerely,
Vincent Mailhol


