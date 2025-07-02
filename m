Return-Path: <linux-can+bounces-3932-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26AFAF138A
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 13:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D29482F00
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 11:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE401255F26;
	Wed,  2 Jul 2025 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tqT6VSg1"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40171244693;
	Wed,  2 Jul 2025 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455154; cv=none; b=QqD3qNbM/GfHHkuDlqSu8fggsPPAuZx/cr7nTTeXoWm8mwsn3phwn18B6tqftdHy5EPcZ383EXB5SxQaHnfByk3D6EhAGIuy1iNKm6tfoifvRcvq3V8zBnlSwkkTsoF8ozwMBxh/ZQPpHzW1jkeubS2LtQfXQ2o01cz22UCpOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455154; c=relaxed/simple;
	bh=vFgPLOm/HF2rte6e4ZbxusmO3v5sRE5ZjJu9SjGeizw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDNBcmRjFlJkjH/G4OG7Na5bZkkciixdeWF/6aSP7PngNQxssd1tKOF/9yIr/1PVN7M/ABQ4N6WIb5drOOTViKcoij6x68ARLAZ/QcHheaIah5OUSA6AR8eoMpqrq/NEMQLMff6aartT/Qtu1TlCal8VkGwoJ2lkW3l7ae+5o00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tqT6VSg1; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id WvUQuOSXovzLVWvURuX85Z; Wed, 02 Jul 2025 13:19:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751455143;
	bh=zY0Vcncre8ymncF/krsSSccSYnb8ci79tIDtcmbKi8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tqT6VSg1AGvOz0HtRL6ZqeRZ50FWwUsVhw6FsqXGN9GsRo/7ZoQ6Qwacqfll6LBDv
	 B5uJamNYlGN+Mbd3eawjQSV4EtaCljFlnWHiyTsaQi8quPA9G4NIIlH0C2Ul4v+MQm
	 hbVHr6PLM+G8wyViMtTiF5eA0C9WtVPzYrpYlCstKoFEiJruCFiruuc/KEI7yyKsYC
	 C60Zf6h38Z/vprDIweUFmh2dc0JBhJj1bZxtgyGTmNZvtUNG0rzfWSo95BSzUZPxoj
	 Cz7GxouzwtNAkfomOkhGcszlfgPGcEypvajDvcKFg6GQln2iR9Eh8BpiQDjGwidPqP
	 7RUhjldGO/Qhw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 02 Jul 2025 13:19:03 +0200
X-ME-IP: 124.33.176.97
Message-ID: <b0e1655d-1efc-419c-8acf-f9a6243e56d0@wanadoo.fr>
Date: Wed, 2 Jul 2025 20:18:57 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: rcar_canfd: Drop unused macros
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Magnus Damm <magnus.damm@gmail.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "biju.das.au" <biju.das.au@gmail.com>
References: <20250629150417.97784-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXK9ZBpgPSE32Zya-nVBXQw25=2-g5pnixjFOoyOkrrvg@mail.gmail.com>
 <TY3PR01MB113463762D1EC916BDE1B7BA28640A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdUcTbM_pbxmbb-kuWf7Kgb=94QtPzRVJZaUrezL3wwN6w@mail.gmail.com>
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
In-Reply-To: <CAMuHMdUcTbM_pbxmbb-kuWf7Kgb=94QtPzRVJZaUrezL3wwN6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2025 at 19:01, Geert Uytterhoeven wrote:
> Hi Biju,
> 
> On Wed, 2 Jul 2025 at 11:46, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>>> From: Geert Uytterhoeven <geert@linux-m68k.org>
>>> On Sun, 29 Jun 2025 at 17:04, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>>>> Drop unused macros from the rcar_canfd.c.
>>>>
>>>> Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>> Closes:
>>>> https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanad
>>>> oo.fr/
>>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> 
>>>     #define RCANFD_RFPTR_RFDLC    GENMASK(31, 28)
>>>
>>>> @@ -298,16 +256,10 @@
>>>>  #define RCANFD_GSTS                    (0x008c)
>>>>  /* RSCFDnCFDGERFL / RSCFDnGERFL */
>>>>  #define RCANFD_GERFL                   (0x0090)
>>>> -/* RSCFDnCFDGTSC / RSCFDnGTSC */
>>>> -#define RCANFD_GTSC                    (0x0094)
>>>
>>> Note that removed register offsets will become anonymous gaps when the register offsets are replaced
>>> by C structs, cfr. commit ab2aa5453bb83d05
>>> ("can: rcar_canfd: Describe channel-specific FD registers using C struct").
>>
>> OK. But removing unused reg offset is not an issue at the moment, I guess??
> 
> No, it is not an issue at the moment, as they are unused.  Re-adding
> register members to a C struct later is just more tedious, as you have
> remove gaps or adjust their sizes (lol, mind the gap ;-).
> 
> IIRC Vincent's biggest gripe is the use of function-like macros,
> not the definition of unused register offsets and bits?

Correct.

My comment really came from the fact that I did not understand why you were only
removing RCANFD_GAFLCFG_GETRNC() while keeping the other unused macros in:

https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr/

To be honnest, I would still rather prefer to see those unused macros removed,
but it is something that I am totally fine to leave to your judgement.

Keeping the unused macro is totally negotiable if you prefer to do so :)

My no-go is indeed on the proliferation of function-like macros.


Yours sincerely,
Vincent Mailhol


