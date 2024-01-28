Return-Path: <linux-can+bounces-167-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D383F94B
	for <lists+linux-can@lfdr.de>; Sun, 28 Jan 2024 20:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A36283558
	for <lists+linux-can@lfdr.de>; Sun, 28 Jan 2024 19:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D34C31A81;
	Sun, 28 Jan 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kq21Bao0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aHDzf7Eb"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A231A7E
	for <linux-can@vger.kernel.org>; Sun, 28 Jan 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706469867; cv=pass; b=FWjB2IwTK9yRC1tDnOZ5ImZitHmu/lyBVcpa6K7QH/KycaWVn7tjqPe3eOnueyxbcggveRQ5lC+4ES005u62LQhzo6Xmsbio8KV9VcGB+IJe+vV0s1b42u8zicuFA5R6wmjRq5ieEgB7IVItfKlXBdh1yIj0/6nJ1bBciDS93Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706469867; c=relaxed/simple;
	bh=UOc22T9AdS0BHVyZ1gpZq3KEsQgFFtan+jqPdsdBXI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggaxcNqyBDHb8y9LGZlXw42pbnVGPDNsxDKqOiGlDs/vzzWXIxVKbdvJVbU0hKZK5EOUvLd71IuVamgYGKIT2Lkq7+VWJNQ+1LOYe5Py+BqkF5JtET+XJwqPef5G0fPzQDXrdq9I6pQR2TZ4HiILKz+xUbF1jiBEDuRawL+NSdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kq21Bao0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aHDzf7Eb; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1706469139; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sPS4atLfXVQRR0nyRnEZcbDSJhPPnMw/HuoYjMmi/2Jfucyur37t0wdUznVPsX43sJ
    8vwxC4c8uNKLu05JyhGoie/XDnae/hk71m4HHR7NWYqBQMtqG9L8Qxz3TYGmnFc2zasg
    qqbHLB7yWCGIpfiK67Ee/efAEP/RK0711eFedr2Z5HikZ2+6xIPwIDEE2hc6UkKDTYm5
    zq6C/Fl7V7+ZieA+LqVVvaZtAJNTO061HxDpL9X7Jfw2ti8SRJmSNQZUq0npzw5E61Os
    WdekbgoN7WIsaCmm/ic1snIWZHfwx7kJ+1x2tGLeQk70Vd91er4E4hHlwyCG9oKg0gaE
    B50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1706469139;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lw9NqPm3dAcSCZqAQMAQf5WxckxwagGavknkZbmLcgU=;
    b=sstDpD+9Jk0PaxEsN4ZM1W3aKjRMk7Apq+kej8ZMWkmDMLg5YIuhV72PKJ6W0OWs3s
    IlfVtag8EULBUDcntvPt+z+9epo6NqI+VWqVG6OdTUUm3yp3sYhpcE9L0q/61xlvnogA
    /pti/w++s2EeESXzyb0WtoIwLvNYIEJQyZRydSdxfKUhvdiRBUWBKeD1EXFHb1qZhjI2
    vgOyhJ+4YcPU+xTO6PabYVCVBIcuNjDMXoWUDYEiCrHtk86Vcyv2lADvu5kQUhF5W4RA
    Cga9vMD6K53ylxYQEt6Exsk0+Lebx3dWWA70EaQfoXyw9UR/qrLPuZnaI6xNfRTUZzK3
    lBLA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1706469139;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lw9NqPm3dAcSCZqAQMAQf5WxckxwagGavknkZbmLcgU=;
    b=kq21Bao0KKmMT6WsAq6lc4nUfmTAQN/6fpqFaFor5C28v3f5Gu9fJmbqmPYg/Gn5sE
    mFIx42HHuZdnLnJSNVyauX+rNQV7O5EYMtODQkh9kEPYWMTyfvmZiNAgpNlPhyQRCF6P
    XEuOQt8BVk6I8SZ8qV2p6RtjIVnQKi8qN/Uie5RjrhAqZEHnyMxwRD3DPAOjcisZWjSA
    NdA0x0zSzkf0DNIKRNQGVucmaBfBIGziHdt6thtPg5Ebs+Vh8VPYHzR/dvSnHMxoYyZ5
    iYJOCtUccc/3kr+j0aiBJ4yDkEPEQ0ioP5VR8gjKlw8uYgW2orqkdWvWU+ESidcMakRc
    bEWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1706469139;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lw9NqPm3dAcSCZqAQMAQf5WxckxwagGavknkZbmLcgU=;
    b=aHDzf7Eb93DTohQNt/43RYvtNRYd1Z360e+lgZRelK9epkzREvohhW+X52bZy3j+5p
    M8qXQWTrUDh3XX6zFIAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDdAnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::90c]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c00SJCJAXa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 28 Jan 2024 20:12:19 +0100 (CET)
Message-ID: <28f2c176-3722-48bc-90dc-7e5ae92041e9@hartkopp.net>
Date: Sun, 28 Jan 2024 20:12:13 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] canxl: add virtual CAN network identifier support
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de
References: <20240108170644.1887-1-socketcan@hartkopp.net>
 <CAMZ6RqK_O1gf+48Gv1fe1xnMb105rq3Pug9q9ZeheDbeNCeY_Q@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqK_O1gf+48Gv1fe1xnMb105rq3Pug9q9ZeheDbeNCeY_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 2024-01-28 11:13, Vincent MAILHOL wrote:
> Sorry for the delay, last weeks were busier than average.

No problem. I just wanted to finalize the data structure for further 
work on the CAN XL hardware driver and some CAN CiA protocol 
implementations.

> I am not yet aware of all the details of CAN XL and its VCID, but to
> the extent of my knowledge, the patch looks good.

Thanks.

> I left two nitpicks. Notwithstanding: you can add my review tag to v5.
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

I've sent out a v5 that addresses both of your good remarks:
https://lore.kernel.org/linux-can/20240128183758.68401-1-socketcan@hartkopp.net/

>> + *          functionality as is holds the @can_id flags CAN_xxx_FLAG
>                                  ^^
> as it holds

Fixed.

>> @@ -814,12 +859,27 @@ static bool raw_bad_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
>>              (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>>                  return false;
(..)

> Just in terms of software design, I am not sure why this sanitization
> is part of raw_bad_txframe(). The purpose of this function is, so far,
> to just return a boolean telling whether or not the frame is valid. It
> is surprising to repurpose this to also do the sanitization. I would
> rather see the above code go in a new dedicated function (maybe
> raw_sanitize_tx_frame()) and call that new function from
> raw_sendmsg().

Right. I felt similar that the naming does not fit that good anymore 
when adding the VCID handling :-/

I splitted up the raw_bad_txframe() function and created two new functions:

raw_check_txframe() (is raw_bad_txframe() with a non-bool return value)
raw_put_canxl_vcid() (which handles the VCID content for CAN XL frames)

Best regards,
Oliver

