Return-Path: <linux-can+bounces-6395-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCgzBk9te2mMEgIAu9opvQ
	(envelope-from <linux-can+bounces-6395-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 15:23:11 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4EEB0E01
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 15:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39754300DD5A
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146B624EF8C;
	Thu, 29 Jan 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="O/6o/B2l";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="88I6owIz"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB01C3C08
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696586; cv=pass; b=nOoR6HCa2E7emUi1+/z6WLLTI92m0ilH88XLRnnTjmdB4ni0MmHT9VOd5st1Fb24pdVMvDpFmPZzqeC35RbDzOIjrxMlk5GFBXPNLr8Yio1iCzeLFZV+B0HlcI6GX0K7haQu0AW+h+KPrRtTXZDhsJj/13UPot0N1v40g717Lao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696586; c=relaxed/simple;
	bh=3Ty6yLrTaaLdgJBocyEINP7Mp2ILkzfSal670zPaSog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ycj3HLJtlnHU4wbR7fc8QJ0sVio0ltxTzjzzhvGEf4ikSY2XJgWg5f6jR419Yx9cO/4Nn7TlQzf6NPqYStsCZ5j2FZg2f844S4360CH855GcWWCeUbZE08XRFs6OM9xZVOKlRhAKg6vYR5/Ma6o2sisb2qTX3zp/DMO/MjVVOeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=O/6o/B2l; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=88I6owIz; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769696572; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OUmidUoPfBj1ThjKdVjXVGat293DpY1w8lb1LyIoMcALuwGPVbH7FnnkcZqObHFHf5
    iNN/BHHOTvcLiePebHeLANHL4vt1NkeeY7+qluN1im0ofy6AzpnJ0YHkQ5NxkXd/CJiu
    T56jbLTd3c7SHt7nrZbAwS2R8fnISq0S4MNkGr0C69pZ8iyFlc9hAs4WTWZ5mj1+0PK4
    iDEss7WxrEFGxLwJ1GMQ+TTahU9MCImQnp3Z2tusT4uY4dRAM8rm2D9awQAIiRSa/pmL
    H3WBY9Kh8/jli5pCw+WotT6bZ87yvye8CLu142CS88YFnxMAbgbGckGGTGHXYcTlSZkn
    GuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769696572;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ihfiW0Xw7c08MazCMbPbwynJx8gmZIcbKafMl/4VMDU=;
    b=LU2JZOdVu7Wl4fc6y6GAh9UvtQWnJqE1uf8TAI+gmnXaQHJEarBTSMtcDDQ7RDDkoD
    fmK473OKuSahbFWSj7z78fRikuwNrgEyvq1efLHZsMw+FTpBzp8u7c1YvZ1eCbod05yb
    WpiaVm75HOGXagNAMQ5m6PQqRNNIlYsGFl7IeHneRTxLwCupriqE6sBnTdtYJ9Sy3hUM
    76M+YpRAQXAFjZ8lbdygO4+IierEBL/CK+sR27WwytslvOOLpiTt7Wc3gLJA4DUBq2V8
    u8uHGab1gLJOMUwzYiHHwsdVWcLg0/gIeACedTYmCztGHfjEsZNBWFG4B7twzid3OKZ2
    hXHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769696572;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ihfiW0Xw7c08MazCMbPbwynJx8gmZIcbKafMl/4VMDU=;
    b=O/6o/B2lV1yMao+lA19fefYXRs5DiUZglgz/0QnIH9T54mXMtosBswJvbaAx23TugJ
    LvYPhFA+OA9SBkhPBUhb9YqZsBPdb717nAb0WrDroumyVZTfxYndYyJ54IqUYmzn2wP9
    5MqNZFEeKgqRKaE/3WWKn8XBAiKxvGKSdPJkhHiCoiR2w/TbcDEMVCAfnVf4pTQDDIeS
    ELfykXk2jCbB3FYjPoAqn0yax0Kf+EMxyyG82BBOWY4ESX1bbt/0Re2U3CfTKJfyMluQ
    mZCm3uhyUUqH+HNHX9V99mm3ZTMHWhUZwqH1F1zWDj9lEhgFJJcfrl70oo2dzfHZeQ6z
    7rZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769696572;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ihfiW0Xw7c08MazCMbPbwynJx8gmZIcbKafMl/4VMDU=;
    b=88I6owIz1dmWY4wgELQ4hsk0GXd1OM5ORHuRB3Ol6yqzNrFG5rvlOOuZnHS0h7qHzD
    GcmBUkJ1nevFOwkDEmCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20TEMqsLz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 29 Jan 2026 15:22:52 +0100 (CET)
Message-ID: <437408f7-95b6-472c-9a30-7a3ad647eced@hartkopp.net>
Date: Thu, 29 Jan 2026 15:22:47 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, tools@kernel.org, users@kernel.org,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
 <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
 <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
 <20260129-fortunate-pompous-chinchilla-dcb99f-mkl@pengutronix.de>
 <c5e95a45-9aac-4a67-82b5-ac4ed8ae2844@hartkopp.net>
 <20260129-skilled-placid-lori-f58fb9-mkl@pengutronix.de>
 <1d9966d9-877f-46d4-a2a8-56b6d621bb36@hartkopp.net>
 <20260129-savvy-vicugna-of-drama-aeefac-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260129-savvy-vicugna-of-drama-aeefac-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6395-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid,davemloft.net:email,googlesource.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:email,protonic.nl:email]
X-Rspamd-Queue-Id: 5D4EEB0E01
X-Rspamd-Action: no action



On 29.01.26 13:35, Marc Kleine-Budde wrote:
> On 29.01.2026 11:31:18, Oliver Hartkopp wrote:
>>>> I didn't fiddle with https://kernel.googlesource.com/pub/scm/utils/b4/b4.git
>>>> nor pip.
>>>
>>> Try the b4.git, you can directly use it after cloning. I'm using it
>>> successfully on Forky.
> 
>> ~/net-next$ ~/b4/b4.sh prep --auto-to-cc
>> Will collect To: addresses using get_maintainer.pl
>> Will collect Cc: addresses using get_maintainer.pl
>> Collecting To/Cc addresses
>>      + To: Marc Kleine-Budde <mkl@pengutronix.de>
>>      + To: Vincent Mailhol <mailhol@kernel.org>
>>      + To: Oliver Hartkopp <socketcan@hartkopp.net>
>>      + To: Robin van der Gracht <robin@protonic.nl>
>>      + To: Oleksij Rempel <o.rempel@pengutronix.de>
>>      + To: kernel@pengutronix.de
>>      + To: David S. Miller <davem@davemloft.net>
>>      + To: Eric Dumazet <edumazet@google.com>
>>      + To: Jakub Kicinski <kuba@kernel.org>
>>      + To: Paolo Abeni <pabeni@redhat.com>
>>      + To: Simon Horman <horms@kernel.org>
>>      + Cc: linux-can@vger.kernel.org
>>      + Cc: linux-kernel@vger.kernel.org
>>      + Cc: netdev@vger.kernel.org
>> ---
>> You can trim/expand this list with: b4 prep --edit-cover
>> Invoking git-filter-repo to update the cover letter.
>> New history written in 0.41 seconds...
>> Completely finished after 0.81 seconds.
>>
>> ~/net-next$ ~/b4/b4.sh --version
>> 0.15-dev-47773
>>
>> Then I can remove the b4 Debian package again.
>>
>> Thanks for the support!
>>
>> Btw. that it does not work neither on Trixie nor on Forky out of the box is
>> not very satisfying :-/
> 
> Hmm, I cannot reproduce the problem with b4.git, maybe you can try
> bisecting:
> 
> | git bisect start $(git merge-base origin/master v0.14.3) origin/master
> 
> then
> 
> | b4 prep --auto-to-cc
> 
> followed by:
> 
> | git bisect good
> or
> | git bisect bad
> 
> depending if auto-to-cc works or not. Then try "b4 prep --auto-to-cc"
> again...

Maybe that was a misunderstanding. It works well with b4 git.

Only the original Debian b4 packages (apt install b4) do not work.

Best regards,
Oliver


