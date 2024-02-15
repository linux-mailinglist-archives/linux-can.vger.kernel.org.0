Return-Path: <linux-can+bounces-271-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B48855C11
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 09:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5FAB2BC5E
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C69EDF60;
	Thu, 15 Feb 2024 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DIFNpJJi";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="i/o4GbLm"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913CC127
	for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984829; cv=pass; b=nPK3pSgSgMQOO4XDU5RZhq0xyDgQbF4QFoJJ7YiX1SlH4Zs+/0YuTMBWLxgngi5iLol4daXQJRVuh0vtIzcHOf6yNuLTwlUl+WNmgqiGy7wKPvcyZhrXambgAPt2eiY7NsGHl6IbMuayVALWKaXraPCl0xZWEnN/Qv0tD0pUYcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984829; c=relaxed/simple;
	bh=VqyLDG09atE1vRUzM+Z+pEDb60wU+WH7nKBgF1uVA0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=st1Ix2Xu/lDklobgDC7p1Q2wtjnnKZ7DFl2KhqfuFkmLOz/OhS9e4M0UGVnYeBzMm4qzJ/E9Crvn2M62w4YX2cN4FPOvOWhJn1PU2oFgMmtaN17RBye1bC7RlWmZTzJnWpDcFBGR9xIYfwinrJb4xMS2Mx/P3nCqitWiMr8/cRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DIFNpJJi; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=i/o4GbLm; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707984097; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OvMUkhWigM6FIc1+PFoQ2wCJ/5wFZhLvD5hFn7Mt+bRQOLHSOyh6EhcfJ5/+ZLACk2
    YIDQzRmOZjd7mYUhLmm+xrVp6oIfs55OV6YI6vsIbyL16te8pO00bEKA3DrOqLeMysI3
    70bbmhf7nQ2WHhJ5SNRZAKpV//tzbVgp8YoicrVqZYSXLfn8mTw8wxbTmq9zWPdyHaqb
    OZOZnsd1TTkjuVnYAsFMY7WB41XO9cQ6eWTYH17TvnNel3kEXoylGocM4kMmw42ggf1V
    xVPimANSk9DzXEtf0f45bJjfoA4Xq4hpUghJ7v7ZHGLsCkQJNQbj+1pMQIgUn1sIDwn9
    lQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707984097;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=18K/9YNXZ/qwkMrz2EL+NAbI/F+YEEqa4VyvAN2Oc9A=;
    b=OzfmMFV/g/DN3vFbLr/Sm66M9gOVDCSZyvWFLWEkXVu9ZWJaKdJSWWPvyhF7iDakW6
    sseIgqvpUw8WJ3es+DgWVx9fgu/br2AWu1TcMjnFNcZ4j1AWR8VgLEOJNOIhqkpWnBDZ
    veq4+Ou5FuM+aucQxXom/QglUsC8zL6T4wSIWROd4hTT0PklP9k0sBo2Gq7R2RGiqFaF
    HA9rlWCmWZRwoXO/bf/h1HTfR5PwKLpHErnBgOnrrBkCRjcmx40nKkW4yau7vApDwEpd
    d8z47G+G7co/UkQf6vtuppMNQPv/iuIS2PK0fVxQ4/skX5J96snrKaOhADTuCy3xY7u+
    LWLg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707984097;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=18K/9YNXZ/qwkMrz2EL+NAbI/F+YEEqa4VyvAN2Oc9A=;
    b=DIFNpJJioEX9GkZtSrznHycA8JUjTeWHvrRsfbx4/f2/+FoCg2DxenkwIvUWP7wtYm
    rdKS239HpgtFiUAAVqhRQjB4hJeGi6G5zIeqm9P71k3W8FWWUNbqPaLamLVvnAFaN5bK
    0DbZ59roFkiywAWlPijJOc36+jnsY2PXZpujbAKFfIuAm8VWXWK/o9SEZVYfzR0EuXcN
    i0J5g9fabfw+SpLgGPGkGMgVOst23ntjt8GWGqsx/doXoFTifj3wezmX+NjauVkW/HpJ
    /06Ag/0NHwmi7jWo5ky7s7BH+tWOsAeZDSvyhZkF6rURxwlZfG/74KUxZ++xkjUvP/5Z
    NzJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707984097;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=18K/9YNXZ/qwkMrz2EL+NAbI/F+YEEqa4VyvAN2Oc9A=;
    b=i/o4GbLmndizBdsaOFMuAz77k+kw3XHkccZmEWxk+7/QXkoVW6astudWkNJz6MJfkz
    +zqFsOgCc9TN84N9oPBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USGY4S7AmUknvtCDiwJu3vjIwWk"
Received: from [IPV6:2a00:6020:4a8e:5010:865a:2c99:b48:eed8]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01F81bwuX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 Feb 2024 09:01:37 +0100 (CET)
Message-ID: <6f86c5ca-3442-4287-bc40-315054a7684d@hartkopp.net>
Date: Thu, 15 Feb 2024 09:01:31 +0100
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <4A92A0FA-D249-4445-867E-5B3838044AA2@sonic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-02-15 01:03, Guy Harris wrote:
> Wireshark 4.2.3, which includes the SocketCAN changes, has just been released.  Presumably, various packagers of Wireshark 4.2.x will pick it up at some point.

Many thanks for the information and your support!

Marc created a pull-request for Linux mainline upstream (net-next) and 
the CAN XL VCID support will now show up in Linux 6.9:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=c83c22ec1493c0b7cc77327bedbd387e295872b6

Looking forward to see both improvements in the known distributions.

Best regards,
Oliver

