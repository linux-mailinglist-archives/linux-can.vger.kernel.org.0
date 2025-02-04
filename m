Return-Path: <linux-can+bounces-2723-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E19FA26CBF
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 08:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225183A30D7
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412D1204C1D;
	Tue,  4 Feb 2025 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XYAaR231";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="xroewzCQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54F1754B;
	Tue,  4 Feb 2025 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654843; cv=pass; b=F26i87whPXd2IDhxh2Dq8+zDilRF6kesJy9bARpJpcusuqRWAW9QG9NCLb4blMv7XPMYSi1CvhEovzx2EmLrXLcsOszQWfOucX6eLkR3DuHJ+iDJ5lWLvjCLVUF71pUOnRCaM5tIp3p/bhNF5M4tA91NYSbHxHcfdXz2U5WalRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654843; c=relaxed/simple;
	bh=Ub78P0MZ3phN/HerCR1znlGmhNIa1hJit7YgDR/NpXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8IKkzkMiAvaY4rdAV4vpKT6S9Ehzw1PLz9un5YCQhUQ4wSDadM3GwJ4yXe0fabvWIchEzNzERKvxA0Mp4GJ4Rs7s40gM758kHN+HoEjlj/FNi7FiEdPTyJatRbEVzXCtA0kE7KYyjJCNFSMQSKavz1ykwehDLxEhpVwtysEZXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XYAaR231; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=xroewzCQ; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1738654837; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sqpFKfD5p+E7bLKym7Vdml7XS9Xv3OR8x+sEI56VV24jyRJ1m4/ilMd+CVI8d5A/7P
    0am9pFlJCTCPCylHu9ec45IlQ7ZXAr3kBgfMbMABstqmNsBZcQib4gNuJSf7eCOIDDYs
    VsyuHBws53X1AgTOcBj3Ah49Z4P8d+Qft3yFmUrNWccuQhUDWXBj4fgePJQvEE1PcZ8p
    IMXFXBKz0Ff+rUHtjhwbmzFjccndv8u1gYZshKvg/mphydc3YO6nWq92b7LzRssH/aqR
    MZ1jpz5v6sT0Y42/EsUSBK3VtBCZufNnxHTFsv9yYJvalri1Ha8UhOpxq9rWwa00JBj1
    KsOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1738654837;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AfwDSoNMJTMEIV7Wr7m13cMvGG2TG7M1Xu/DSl38KcE=;
    b=fbbeD7aS2mPv/Aj2O+lbOTB+/m/4DGeJUnGys+vQymJPENfHDfGRsqo3ahnwlyxc8J
    pYrkcD+RJ0NJ8B5jn1x8Ay1pBu8ASRuXLuDe4bpPdXgHrI4nUrz0ByiVPTOAqvNNlwQs
    USNBh7lDzTGTeKdaQ/9jMZP4qexriCEaW+emVr1DuXYw+OtIIAlh0h/NXMS1FO76e1z8
    2a1vVhaaFYumWjPj3CWvbyHgXh4wYPoT9EOMecnwY47dkTMZ7ovxUl+ANABUhfnS7tL5
    B9T75FgUpBJju/OWk7HbOyClIf23AeHJNDhCouc79wxL0pdWj5I1XRXJxLRDcBY2JrT+
    TOrQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1738654837;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AfwDSoNMJTMEIV7Wr7m13cMvGG2TG7M1Xu/DSl38KcE=;
    b=XYAaR2318oITKDbvl+QV8RGIkkB47DoRBcnoWWo+NU/hUCSDPEPtV7PVbzMKkn4kU+
    4/4gymSaCnNnmfXnO/U01e/CyZtaIHbFNpk286Wt9v067C5KhvCVyVAFRojtOv8e9XDu
    YHTYZ2rrMYm90ag/ggQdkaanNEfxVoDd91hHU79ON/y+xoftFM3Tfhs22B3B66GIoF2e
    CmNojjGXIN4nyEzEihrUgdKOVzo8e8ItMbUCEBEHJS5dXvvMLv5+erT+lxtZYsIlb6vu
    xoH/rW6qvakbty+75NSvLGwIWwcOYKnY2ywguqwIjjizwS9cgVS42imoGEqplzZKAoEo
    tHkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1738654837;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AfwDSoNMJTMEIV7Wr7m13cMvGG2TG7M1Xu/DSl38KcE=;
    b=xroewzCQhPdJRWIl1CgoFuP9vlXlw8yAHPkRj/gpY8P01wXSuZBfbzEAvtR0+qScyL
    oVJ9SRpMrhCe6cYQqRBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.21 AUTH)
    with ESMTPSA id Ka08e41147eYI03
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 4 Feb 2025 08:40:34 +0100 (CET)
Message-ID: <d63b3475-c423-4167-806b-97f22258cb07@hartkopp.net>
Date: Tue, 4 Feb 2025 08:40:29 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/networking: Fix basic node example document
 ISO 15765-2
To: Reyders Morales <reyders1@gmail.com>, kuba@kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250203224720.42530-1-reyders1@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250203224720.42530-1-reyders1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03.02.25 23:47, Reyders Morales wrote:
> In the current struct sockaddr_can tp is member of can_addr.
> tp is not member of struct sockaddr_can.
> 
> Signed-off-by: Reyders Morales <reyders1@gmail.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks!

> ---
>   Documentation/networking/iso15765-2.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/iso15765-2.rst b/Documentation/networking/iso15765-2.rst
> index 0e9d96074178..37ebb2c417cb 100644
> --- a/Documentation/networking/iso15765-2.rst
> +++ b/Documentation/networking/iso15765-2.rst
> @@ -369,8 +369,8 @@ to their default.
>   
>     addr.can_family = AF_CAN;
>     addr.can_ifindex = if_nametoindex("can0");
> -  addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
> -  addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
> +  addr.can_addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
> +  addr.can_addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
>   
>     ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
>     if (ret < 0)


