Return-Path: <linux-can+bounces-4629-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95936B511C7
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5BD7A3D8A
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33BC2C2356;
	Wed, 10 Sep 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pJI0ZOWL";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fXxQwMeb"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06230F93D
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494144; cv=pass; b=AukrNac5pzD9yJ0AmErYB2qPRSOahUn031lWrbTSLLSvLOc4oAecw0cfzEigE7iPo65pnAracX1H5ziReHV+ESqoN1PvjyDlL9k85WxrrPrnAi7QaSgE6Xd/3q8CTMU+LYblFzTJsxG4IUV/oVp5NBCZYW7xxCEjnOpRYMldMwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494144; c=relaxed/simple;
	bh=ofTlffrv6SZUT2/zgYzw0hoCEE6+SZHrmc0tOPu30MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OjR5l43yqdccG1u0Op8W8GgDq7UBEaJx/+4m/Sv8+aNsv/V5LNDB7uNb7Ht42S5HxgARYQZWnrDmZj0TUg9TKtrrmIvuh59sN+W9Be+FJxoTXQQWout+c+OhGCZWMvOmBqAAJ6OHdVYLfcuYil894HrleSbkymDXNxrlGwtGKME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pJI0ZOWL; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fXxQwMeb; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757494139; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SoKgS51fx2tk7F2zdb09WdatElVige3OrLHlCei3OPMZgBJFHh9ZhZ34TDA9Y/cX4A
    wCC/NJlUrGeVZOafKX3sjqGVBmwr3rt+UgxalR9S8RwKxtacwsqUsv/Mgm+jjCA95SUA
    3K2nSnwkOnjl9M99ePAvyRU/96LMecFKe8Bb/UBXe6vuRgeCPh22mXzhnDA60DW6F6Ga
    Zh5YTlRmfIi3wjslDVSbnvp4/Npy2bX2ntlRaW8poO+pNXAQVw0HHvz2vj6sVPkU2O5I
    5CEZbp4N6uO6QWPuS2DS2dpbtDenefCjtukbkTOCWOF3/kKOaVCKJ0/z2n5ewEhbsaqZ
    fadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757494139;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=15VvcYXnCDgh2YQH3JtlRJ9B6SfYbrICCZZ0atxzCkQ=;
    b=PBND+/89nxBpeU6O+6Y2H+ncH7Lfqk4wM9YZMXO/YGn2ZM96l0y6538voj/HS4YpSW
    augC7MbUPxYHfna6QBEVwp9H12OsdIfHbG7tJpbCJVPgSg+ZzEqzloECOiL9EtWwH2CU
    G3D9jyvq5qr8kAG+h87LJEm5y8LtH3qG+ST7Nhn/y7igzvWttMQC+Q3aJ3KIzTOV+yTR
    tTU7v5SktAdQwYQgy/ogJM/usD3J+5kAM0KxevrEpK39tXfU2jjdEO4ne1Ixn1jwLVqQ
    xBSJxBBGyEcu3+0z5mkFJfd84gUQoQW98OrNldqiPFHf0UNNhp//r8YWouovLQMKhF7z
    x0EQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757494139;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=15VvcYXnCDgh2YQH3JtlRJ9B6SfYbrICCZZ0atxzCkQ=;
    b=pJI0ZOWLZurrGPan0PwNeZUCAXNKi7vjRbKQnJNE26A+/GOJVoIntWrJ9A3KW+gISy
    90BDlAEZ1YvTnMLISqjs41btXNHaCHQTmozVy3d1P/lLqLgFK1XhxqDSyKWNIfkywOEH
    4EpYhTRzMyPhmvbizbAssSCiLT7L2t9lCmEZ8Zt/dqgi5+1xH4aTUn7aDsCFpaLRlQmp
    Wseu5puO1oHlSEAhqHvrE1SOI8IKZQrYdxDfpfQDVSNjxkKEOkCGKPOJL5nC89ONFRA+
    ba8jPUhk6cp5f/k+HttmZhOhMOBZVIMfRs6nLGp60EOyefUkUIOkbe+4n0HT+lP6VlCO
    niUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757494139;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=15VvcYXnCDgh2YQH3JtlRJ9B6SfYbrICCZZ0atxzCkQ=;
    b=fXxQwMebfQmscxX6e/wmwCR8eqhTFA/xcZLS+RUarneHk3+HYsuj1FcTjoV9mhYXiJ
    JbJtJd6nr1VpMb4W+QCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36118A8mxorw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Sep 2025 10:48:59 +0200 (CEST)
Message-ID: <3a963548-faa9-4611-a3cf-e41b425968a8@hartkopp.net>
Date: Wed, 10 Sep 2025 10:48:54 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on
 CAN XL interfaces
To: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20250909092433.30546-1-socketcan@hartkopp.net>
 <20250909092433.30546-2-socketcan@hartkopp.net>
 <f7b59c7c-30ad-4cf4-ad0e-bff0e39b3337@hartkopp.net>
 <7578f44d-d85c-473e-8e7a-65d1fc974e68@kernel.org>
 <20c5c885-0bab-4c42-82c6-e98571a5d19d@hartkopp.net>
 <552631f3-15fe-4bb3-a512-1eaca57be5ca@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <552631f3-15fe-4bb3-a512-1eaca57be5ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.09.25 09:40, Vincent Mailhol wrote:
> On 10/09/2025 at 16:27, Oliver Hartkopp wrote:

>>>      /* CAN XL is allowed on virtual interfaces if it fits the MTU */
>>>         if (!priv)
>>>             return dev->mtu == CANXL_MTU;
>>
>>          return can_is_canxl_dev_mtu(mtu);
>>
>> The MTU of CAN XL interfaces might vary.
> 
> Maybe this is something that we discussed before, I do not remember, but how is
> it that the MTU can vary?
> 
> MTU is the *Maximum* Transmission Unit. I understand that the size of a CAN XL
> frame is variable, but the MTU should be constant, right? Why can it vary?

Depending on the realtime requirements the length of the CAN frames (and 
therefore the time the bus is blocked) the MTU can be reduced. This is 
(like the bitrate settings) a network architects decision which is 
enforced by setting the MTU accordingly.

Best regards,
Oliver


