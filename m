Return-Path: <linux-can+bounces-233-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F298B852C95
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 10:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FD11F26D67
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00DE50A7F;
	Tue, 13 Feb 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iUK4OWag";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tyWGoeSV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846AE4E1D7
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817076; cv=pass; b=EiT3u+QxfBRETRV+K6v8eYFH6X7a40BqsfOd0T9Uu6g1G+Ah71Ue5L/sbDjb6fv1IaPlVXft/im7YYaYqhnvumAPtr8ed6+BfrehQ4nYTW5yFmNgdat9hp/OA0Z9mQW9EURDMiw/gJlcBqYhIY2OCGO5CQHYSYnt1IQ9pe2UyQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817076; c=relaxed/simple;
	bh=9mV2ppDI3oA/EbHshsTOM0E74zYx0ZsakQmdFU7K4ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0sqbxG8StMVqcREPfMqtuo851zbEik1S2prjy0KBiN3RKWXmkmUCi2jFvuHvjYtSjyjlAF4maDG2snkNORjr1SxG7VTIDv4JytuGV0P5qk8sZ57miyiGqyFdIFm7h3uAzYDbphvbM9+ddI/chh6sGLab9GssN45fipmRlZCgqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iUK4OWag; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tyWGoeSV; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707817068; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NvGSY9MWa5FYQR3q7KWiS3vntkaD8ePtCdphXtOf/ZAAgr2fsMgECiJABzvrm8pBu2
    eosyjKdXYwwOztMElwpPu2k2YhnYGlmG0+LsFoAsTZgAXyUO77gpYHDFGWZU1PsWhPuN
    AtQ1rOkDZSi531iAAyYsycWNSHyu71dnzlVDed/eUOcE9z7Edsnh7hXGs4ZNM1syEKnF
    /Igef5HcJWF3DllZo2Dj1sJhTUoxm8Ymn1e5bTT+NrHT6wllWEs32lNRe1vLwhtbOwEP
    xCBBKAlINAlBfRvuNFzXraXUKcieJxY6MH5PXYPCZK+G/iwi98euEPmD1ou2mzlkT9vD
    TZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707817068;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1YblpY2g0zU7/ysZVIUQrzWGo3LzCp/gmeeIR2rBQwE=;
    b=PxH6c1g7nJ5Nsal8rl2FB6Bequz0LkqlQSn9naOopip+9OR7DY5HdSjn5i3bNBRvZc
    F6A1aq2ex+kZytE0Ui0bhn/4CUUCPjmZd2jpBXO1U8kc6M7C4Zo0ilffrFhonAk69485
    4ShwxhuACPd3hPMWpeZF9j8vejvAKgTA5l8s+Qw40ExzJ8ANAjUX8HcnVU5ScWL+7gNT
    Mo2dcUVNWK61ML4RTFg1732/Y2lk62jETiZlAdN8y4a8QsO1HHRT+R47Qyp+L2G6T9to
    IHfkH46WdF5Qew7XYsgii2SHQnC1pVo4GMZiWfzT5aHPN1adKsFKgIJLh9H8Od+gr2xx
    hiMg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707817068;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1YblpY2g0zU7/ysZVIUQrzWGo3LzCp/gmeeIR2rBQwE=;
    b=iUK4OWagsJGikx0CAfXF+3+gSFcn3sXKNICQSvanK7jfJiEWriCg78f5gmaY1nQrIo
    Sis0WLUJ+XyXdDcewRfV9lIbyvKpNvv3+x+i8XIyWcGgoGGjU6JIm5e1IvMYsp4VI5BJ
    WoHkkZO2ztxMNKvGk/TYXifYHPdHzLmZyX6OnmBdq2lEiqGtikPmeHlHWg4tvL/Jl2sF
    TmEwr0mbHr8EBJOyrXiovAZO7bteGgcU6kqDzELyMjGxC2pZf+5EpciPZIqFdUX83TcY
    67qlaHItkH8PkgE1Geibl5RZUo2asgF+xM6+Yp4wJP2jODX2Ps93QaHMaKm++bcm/ek1
    FU+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707817068;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1YblpY2g0zU7/ysZVIUQrzWGo3LzCp/gmeeIR2rBQwE=;
    b=tyWGoeSV25oyy1UIOzIvtB0Pk8tAyFb8CGbJLOdJvjgcWRmdeHk60+eFPFsUvYwHRi
    YcH3czq1xkyGw9D0NNDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USKMwcOWj4u7uw8xIRvyV5DfJD0tw=="
Received: from [IPV6:2a00:6020:4a8e:5010:4f80:462a:46fc:6ff3]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01D9bmrKC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Feb 2024 10:37:48 +0100 (CET)
Message-ID: <05ae1eca-4bb6-40e4-88fc-791cc2051da8@hartkopp.net>
Date: Tue, 13 Feb 2024 10:37:42 +0100
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <23C4EECD-622A-412A-B965-8E586D9360B2@sonic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Guy,

On 2024-02-13 01:28, Guy Harris wrote:
> On Feb 12, 2024, at 1:15 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> 
>> Excellent! That seems to be the right approach.
> 
> OK, so:
> 
> 	fix libpcap to put the priority/VCID field in big-endian order in CAN XL frames:
> 
> 		https://github.com/the-tcpdump-group/libpcap/commit/eb6cfd8feae85b67529bb3c82f6a97bfd98c73f3 in the main branch
> 
> 		https://github.com/the-tcpdump-group/libpcap/commit/23904ebe85c4556b77578fd8d61ef82d9bab62b4 in the 1.10 branch
> 
> 	change Wireshark to treat that field as big-endian:
> 
> 		https://gitlab.com/wireshark/wireshark/-/commit/38a29e82cc96f727aeab7f10e751fa6e8d5e45b6 in the main branch
> 
> 		https://gitlab.com/wireshark/wireshark/-/commit/b763663904b6101764c414056b9248803569d6d2 in the 4.2 branch
> 
> 	update the LINKTYPE_CAN_SOCKETCAN spec to reflect all that:
> 
> 		https://github.com/the-tcpdump-group/tcpdump-htdocs/commit/9c357d9ed6d214bd2fc44850138c2f8861782d88
> 
> 	and it'll show up on the site within 24 hours.
> 

I can confirm that all type of CAN frames (CAN CC/FD/XL) are now 
displayed correctly with the latest Wireshark 
v4.3.0rc0-1528-g37937ef51444. As expected I just don't see the CAN FD 
flags due to my current (outdated) Debian libpcap 1.10.4.

Great job!!

Many thanks and best regards,
Oliver

