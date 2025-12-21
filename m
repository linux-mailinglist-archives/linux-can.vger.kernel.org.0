Return-Path: <linux-can+bounces-5894-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8DECD450B
	for <lists+linux-can@lfdr.de>; Sun, 21 Dec 2025 20:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3EA9300769C
	for <lists+linux-can@lfdr.de>; Sun, 21 Dec 2025 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74683286897;
	Sun, 21 Dec 2025 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VtQxNaAE";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FgpDFrgJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33450276;
	Sun, 21 Dec 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346324; cv=pass; b=pO3BWWfCx47l6fZJA6DOr1PrXHrEZeJADrg46O+78KG2PToWjHTlhvTQgZE9aUV6Pr8DkA1UdgqUJEqGpcLIc/pLqPzh7pN+VxhQbzZrUwjRMtpPHGjAnltqeVRVTnmBo7FXodlv1Igpg/59NaTTOKlBhKr36dV4TkoZAfGrXQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346324; c=relaxed/simple;
	bh=i++1cctCPW5K7SGM/RAotmNGTpyNeau6wRii2AA4gpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ix1FKa2o5kwJzRLhVgeskiPx2KFfV9NrNurmRP8mYZZpuszdaizZQkQuf5Y70pQSRfSBjJ57nB8uARMSIoRYFleMMP/Bz9IlL/hoN6v662PcqPQQD3yayO9gXNl/xM48zMqsjQ0XnuKpLGFQmill5Ko4ca19UxtM+dNGkN/p6OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VtQxNaAE; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FgpDFrgJ; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1766346137; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aEBxyLqjOrTKNjjQtp9+JI+Uuj+aYgNDYZQurSVUFpk6lTodf++G2qR4QC3ZOktoR1
    DkkeijDSjn+txRogZyg9FCAcZbhyT7AiVXDO6nRkgHarKg/qdivlTXlzquA7rA3zz5N9
    8alem3KZ32iofZca7Ujmz6a+hpCXdzw73Cd0EQI1ppDKpKrZH+PSIqwbhUe3PnVFfsjJ
    M4pkTrBRJBRJnnmwAR+gfD/t8uWiTtq90wTR9LYE53/gcmCdC1aYK2pAn7vyUOGB5RFF
    PP5bc68XMGPmvksTT2qq5SEiewpM0o9RpGHayCpuZTw1JYN35eImRcvV+OgSEdFoDVLF
    FCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766346137;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9A23g+fJ13s8kWcxp/C6OaQZwQpjkbSEThho02wFN7Q=;
    b=I2fu6/MnuB6RMi0iyQ4DKE/oimf9k2CwV1CTX//wm+QCkMGB6CUYzqG1kKNE6odQQl
    dum0q+HwKlciMsQXSbk8uFNg9ft8h6y3l8bA6dETLQ9wgtZspTYFKdKP4KbFazFQhS5/
    u6qI/lFBoq5HDfXSnou9FSxgni8vzDfXp8YGB8nQPrgI7YECKIFxXVP4YhXClbVhEsx3
    q1OrALDKnc53PsXr9lKbyYyaLLZJYFcMX//riVlrjcxNh2B6gEFi7qTb0K0N6oeeGr3I
    yNpoRt1IPQ93d3o6iypqQucX1bbLWZurwf97epx9XJUI20drvyOqhnjUvD9tObZ25kGI
    PDNw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766346137;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9A23g+fJ13s8kWcxp/C6OaQZwQpjkbSEThho02wFN7Q=;
    b=VtQxNaAElacSC/iSg2K4Ig++0zncS8C4e21ZZlTv7g0JSaXYor777otArlgvbmDllO
    gmwJvnT4mg6dOlTNNOELVhfrTWd31r4TcZa+ejQSHbu0kp2iZUfNWdheF7h9najQIMru
    BguVYfpkNkZ6q1QgPu4ZzH4wwpSKbLDC4ls3PU6G4LSwqVS4RiJj6T8jthdJ94E7/+h3
    k8JWrqWt8qzR9TqczuXn9Vj4hMNaO+13uYMYO+b+lfxHJoPw3ZC5jQRR+AQdSoqr1Whk
    BKs2inlFhCOpTiCoctCuzb6RV4PoAj+8PhquoUhaa5NOxglv/ctayXWmd8hYnA+oTKss
    Q9Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766346137;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9A23g+fJ13s8kWcxp/C6OaQZwQpjkbSEThho02wFN7Q=;
    b=FgpDFrgJRJzXFCe8lkfIZH7dk2uvWx3u8SuUyk6i+h6h/z8o0Jya+5d0J9I5b6UNZ5
    GxxGvoKkOVu5w1Ye0oAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b1BLJgGDvq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 21 Dec 2025 20:42:16 +0100 (CET)
Message-ID: <d3fe10bf-1505-4c0d-ab46-5c56615e328a@hartkopp.net>
Date: Sun, 21 Dec 2025 20:42:10 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>, Prithvi <activprithvi@gmail.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
 <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron>
 <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
 <20251220173338.w7n3n4lkvxwaq6ae@inspiron>
 <01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
 <20251221-ochre-macaw-of-serenity-f3ed07-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251221-ochre-macaw-of-serenity-f3ed07-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.12.25 20:06, Marc Kleine-Budde wrote:
> On 21.12.2025 19:29:37, Oliver Hartkopp wrote:
>> we have a "KMSAN: uninit value" problem which is created by
>> netif_skb_check_for_xdp() and later pskb_expand_head().
>>
>> The CAN netdev interfaces (ARPHRD_CAN) don't have XDP support and the CAN
>> bus related skbs allocate 16 bytes of pricate headroom.
>>
>> Although CAN netdevs don't support XDP the KMSAN issue shows that the
>> headroom is expanded for CAN skbs and a following access to the CAN skb
>> private data via skb->head now reads from the beginning of the XDP expanded
>> head which is (of course) uninitialized.
>>
>> Prithvi thankfully did some investigation (see below!) which proved my
>> estimation about "someone is expanding our CAN skb headroom".
>>
>> Prithvi also proposed two ways to solve the issue (at the end of his mail
>> below), where I think the first one is a bad hack (although it was my idea).
>>
>> The second idea is a change for dev_xdp_attach() where your expertise would
>> be necessary.
>>
>> My sugestion would rather go into the direction to extend dev_xdp_mode()
>>
>> https://elixir.bootlin.com/linux/v6.19-rc1/source/net/core/dev.c#L10170
>>
>> in a way that it allows to completely disable XDP for CAN skbs, e.g. with a
>> new XDP_FLAGS_DISABLED that completely keeps the hands off such skbs.
> 
> That sounds not like a good idea to me.
> 
>> Do you have any (better) idea how to preserve the private data in the
>> skb->head of CAN related skbs?
> 
> We probably have to place the data somewhere else.

Maybe in the tail room or inside struct sk_buff with some #ifdef 
CONFIG_CAN handling?

But let's wait for Andrii's feedback first, whether he is generally 
aware of this XDP behavior effect on CAN skbs.

Best regards,
Oliver


