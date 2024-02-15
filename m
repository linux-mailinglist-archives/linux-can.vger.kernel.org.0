Return-Path: <linux-can+bounces-279-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E3B85630C
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 13:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84990B2B407
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A72E69970;
	Thu, 15 Feb 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NzP3VoMq";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="8ZPObUfS"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9312BF06
	for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999643; cv=pass; b=r2SZVbJBKMFK4qY0aliScIg6Ket+cCiFBkEJ4FE1XH5dCUiZwzrWnL9CDPETInf3T/8Uzxuz9Y+Equuygxn/soSBTP6fidUSkXYZYBb16tHklq9bg46X9ipE7ctiOh+BL+1+xBvDxhv0Mg7OyBNY24qMYkpt8NhrnOHIM27LMWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999643; c=relaxed/simple;
	bh=wzER/3kfc/wfAWOLeV5vuGj3uOAs7qxfxPTNmOnrEsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEjxTWmsyUgSANp+qfh8GMg59JXT1aeTk2JRBiDivyayehqKkZaiKu5uyRwKSeVgXxgQ7W+jCgTcZC5D5C601tOFQ0UyRaHt27cJPSs4JOBam0yZFfvQWSmzmU5ADsnZmLqj48Un2tGvpe9WtwWBtg145Lt9nkizoPylLQ7bxwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NzP3VoMq; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8ZPObUfS; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707999631; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P5DNnUPp9oTM0wPsoxV0q3I5aDxxiyXpgLv4ORNw5g8wmlck6hCOKCRkTm4g5nM06d
    SC7dgii2JG+iG5OPeUEMbZN13cZeaDa22B5gHJmOmvxNvdLMrKOa43dgGX7GJtQWmSOG
    25Zi7dcjArtvy6aYT+qG+zMaSvWKd6zKtsF4rFsyWqt61fozyki6MKtElWWE3RwEDv6q
    oTD2QJSgeECEvPfufGPv6nufDJNC9fix2t1TFF2XT6YjUX8xTU/dPQsB8v9ceooMQKuY
    shcaSna1jPCfeb19FK9hzJLNncIbpoei7WrFGMQZXDoOGq7wfy49PGADbSNHTxivccUI
    Rqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707999631;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kLeyr/rSs9NXu9ZWtE0WoZ9ZgqvJSLcvWvTc+QUnldo=;
    b=Z/OK3X1I7CWYBBpydQ92meWS9wCMGREssfcuQysxHIw+zoSNNKk6jtSDSRGVB8XB1x
    IHau62yc7t4QqqZMarC5LylGec33pv4G1YHHt2SRFl88CFTzAgIIuvpEpf98OGxNlN1v
    wWBSIv0vvcLpUZYDz2/T54Z16M6bEiLx4/VjZcf3p2LYMJ/FH3BXCUpyN5yYE41YUmlZ
    AUzvN46xVSsXK5/PTQiHvpvLdJrbjp2SZjWjOCh7I/JhjVEZcuxLuS/ETh3mz2281oct
    n6t5PnHTFJtwqjBGxD6UQGNNQPmesi5hAizuf6YexjFyKQyp0kd/Ai9psY5j8j4PsArb
    uBKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707999631;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kLeyr/rSs9NXu9ZWtE0WoZ9ZgqvJSLcvWvTc+QUnldo=;
    b=NzP3VoMqAe5xBDKfmEJISqH8TqPCfNtXqwEMug/J27O7k+weOd4jPPdOE9uzrasujx
    OxytsydpUT8ipsiYwM7Gc70t+VlmB1DRHMlSICfcf0ebPh4qxjDvKUaOUXd6yY2thAOy
    0zv21j8UUBJQFtQsklcP10bl4GoLqCqFBh8y7BaRPIqCWC3hnIw9TRA8GWHTO+YcJEWO
    3ZSsKhoWlEsE/HOsrg4sbZX3/gzi/Ax5DrAjuaW3ruxTg4ICouy2p7SOuMdS1s3/hOlL
    QCoa8182z/FSVAvz5SqDX5RtatLBJw4wVZAigycA0R2YBBSpuWoQgRfOfrHA9Yxw11Pw
    FQvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707999631;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kLeyr/rSs9NXu9ZWtE0WoZ9ZgqvJSLcvWvTc+QUnldo=;
    b=8ZPObUfS5gydo2MDvbKvKb30YQRARGgsvZX00MKGd4W6DZgE/2hcQTZLIBX5uVxnQk
    skFG2l9W1sneb8MpOGBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USEbHoO0g=="
Received: from [IPV6:2a00:6020:4a8e:5010::923]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01FCKVyAA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 Feb 2024 13:20:31 +0100 (CET)
Message-ID: <96228a83-4aa8-4ae2-81e9-aed49ed0bb6e@hartkopp.net>
Date: Thu, 15 Feb 2024 13:20:25 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Wireshark-dev] SocketCAN Support is broken in latest
 Wireshark-v4.3.0rc0-1430-g600de02805d0
To: Guy Harris <gharris@sonic.net>
Cc: Developer support list for Wireshark <wireshark-dev@wireshark.org>,
 linux-can@vger.kernel.org
References: <2dfbf765-5a0e-4b72-bbbb-2649bba7afd8@hartkopp.net>
 <B237C266-B7A1-4F5A-85FA-F41FBC71D839@sonic.net>
 <DDFFD43D-2CC3-482A-AFC0-B0EEDE5B7081@sonic.net>
 <9C5FF793-DD38-4738-9421-C8C411E405D2@sonic.net>
 <525f7e66-1b8a-4401-b6a5-c55462f12f4a@hartkopp.net>
 <2CB7E192-7F5B-4651-B0B1-9C3788489B8C@sonic.net>
 <550c630a-4fba-430e-a0b6-bacce3776f2f@hartkopp.net>
 <B9FE825B-F804-4D09-BE01-1D5592D1077D@sonic.net>
 <48514D53-9257-4613-9F10-09086D93C2A3@sonic.net>
 <68889df4-1ac5-45c0-8820-737cbcc30c56@hartkopp.net>
 <40ADC6AD-C4C3-4954-B58C-FCD227474C16@sonic.net>
 <48b90be5-7dc8-46f5-a2fb-bc9b310da410@hartkopp.net>
 <5D9B69B1-A6D2-429B-8862-5CB60415D7C0@sonic.net>
 <aa3671e7-83ed-45ed-a843-d9ed238519c6@hartkopp.net>
 <23C4EECD-622A-412A-B965-8E586D9360B2@sonic.net>
 <05ae1eca-4bb6-40e4-88fc-791cc2051da8@hartkopp.net>
 <4A92A0FA-D249-4445-867E-5B3838044AA2@sonic.net>
 <6f86c5ca-3442-4287-bc40-315054a7684d@hartkopp.net>
 <D27F6435-783D-4D84-B525-53B7FD58339F@sonic.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <D27F6435-783D-4D84-B525-53B7FD58339F@sonic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.02.24 11:43, Guy Harris wrote:
> On Feb 15, 2024, at 12:01 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=c83c22ec1493c0b7cc77327bedbd387e295872b6
> 
> How does one request that the VCID information be provided on a PF_PACKET socket (whether SOCK_RAW or SOCK_DGRAM)?
> 

The VCID is now part of the content in the struct skbuff data. So it is 
available everywhere, where a formerly CAN ID was accessible. Also on 
PACKET sockets.

The VCID is no VLAN tag, nor uses it the VLAN specific skbuff elements 
in Linux.

While it would have been possible to get a VLAN tag via PACKET sockets 
auxiliary cmsg mechanic you would never have be able to "write" the VCID 
in this way as user space application - and especially not as 
unprivileged user. And this is a vital requirement for logging and 
replaying CAN (CC/FD/XL) traffic.

The question if we could invent some VLAN-like CAN interface (can0.123) 
is to be discussed. But there would be the need of a use-case of real 
CAN XL users. So far there is nothing to see.

As CAN XL has up to 2048 bytes of payload it is also possible to do 
IP-over-CANXL. IMHO it would make sense to create a software ethernet 
device (maybe with VLAN tag) that interacts with a CAN XL network 
interface. But this is future work, again when there will be a use-case.

Best regards,
Oliver

