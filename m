Return-Path: <linux-can+bounces-5662-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E1C8715D
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 21:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC16D3AC301
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 20:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641092DEA78;
	Tue, 25 Nov 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1bdf/Vc"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F82DE1E4
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764103283; cv=none; b=pmIvKYFR8ddjF0Vm7yuXMZdNDbJtnGkTbYciXxNhlWLYOgoANeQdBsyadpFKxiI8sFK5ev/fEpHL//bWMg+VNes8Ysvm1unT61PnGLV9VIH/BSC3092M4Ww1CX8qJe28cidGZnzBYoSCW7nVYp2L98rGbaJFK7CNWxMJunQ4uog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764103283; c=relaxed/simple;
	bh=b8/nlt8ySur5mYAp0cy5opUeHPZV6hdxWLfR3l/E6aI=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=mXqMgbvqID/Po/n8BhIolAXRU8UmYeLvaasld6mEFxzB1pjl7Plb8bsPTxFMg/lI/2L5ppxwrr1Sm4OEUFTDZhCmTmrVFXwv7JWFGM8BM+ezv7Dcx3QDiaNsyL74wltRqZ3V4MNDhHsql0DPw0CM9dXlaNRmVXJdCDf657QUyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1bdf/Vc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2956d816c10so69452505ad.1
        for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764103281; x=1764708081; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8/nlt8ySur5mYAp0cy5opUeHPZV6hdxWLfR3l/E6aI=;
        b=L1bdf/Vc2Phn9w+CrA9Q4LnqlxgYLY1WJtE82m/sEJ6eBnjbyFbVMv2poXvfEEq7lY
         ClM+PFN6XPA1elTTxw9GrKI9bwHOZuE2V0B/R6cZnfBEzGsGv+7d8wttrCYdNxbXpQMv
         sX0CvXxOslxe5T8UtSSRUamL5QP2ulwsHwfXg7ba8GxgSphxNOECs1CwGaEJbXzD+Hc8
         z16mv44DknvIx0X02TFTYDXU40VpFg3R18Hzw03N7qCdzgk2mlD2tdPLNL1jqSY4SuEL
         0qp8yRIM5MkLkhKqyps1qVToWQtc3L7NeP1+Axz3rtF9MYW9sSWVdKs/6GNo7ItEthcq
         jGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764103281; x=1764708081;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8/nlt8ySur5mYAp0cy5opUeHPZV6hdxWLfR3l/E6aI=;
        b=RgaKP9CVNNT5JUd8US8mmzhg/3l+0eh/whDQII/uF4fXDMm0LsbvKC0RcSOKytZwkw
         6AKqx0MPsFyU8paIY1kI3tuUom+qkoubYNnnoE37oTfHsqws0x/WWp3o0qG8SS1WfzYH
         qg63Vsfe1cQdSdqjrQh3kO+yROJM/LnV5DIlkf94wu5+8dQNcW2bag4FS0ZBItz6eHyk
         aaLW/Y1noLqynnpzerK1VX0fZzDAjF2roMkjXfvQeEApuUn3obBpCGdb4s+yTRbz9ZB1
         bTltuzKhHiI2yvk6+lv/3Cdd7bK3Y1BzkJ/xtArK6ye0gnMdD7+uQm//ktzF3s2oIvqa
         EvzQ==
X-Gm-Message-State: AOJu0YwWxtQLATOvsf2fbojvik7VU8nuLGYS2sibE2kwde7EbGyhOFpO
	pG8JMkTjup8HzrD49zXCVKtIBmaL+hKfpR/qxhuGiOrrOJSlv3ZGvv/h
X-Gm-Gg: ASbGncvC34B6pBcZiuDFXJJazR02fE44/V+pCCbanLbgAebOImHTw1MeKjiS8m5wU1a
	1G8mA+EtYBvOAN+gfSe9aA02Hkxm/l9Ttp+e8v0HmjjjUV2p/rKAuNVfvQtH/CAJYD+R4dQ/DP8
	DC9vvxmnaugSc7Y/8ttjEniRTZtBi2HfzEPG1rOP3lZqkcmpdfFGxhzljkov/gA2ShQjlk3tNAB
	iUSpnmjm46cfNCfLK8tBhUkemNg5O79naReQOSANLQraFZGqweuqpfU7SLuBgbMRkYsLgzuRAGK
	UhXGzZfs5yRcDz5/s6iS27uHzc0bumMZUo2VShjYETLrAaDCnZRbyKKGHKyFEwAhzArmNY2591o
	m3cuC2xNhMoVY1oNuOHRNOlTY5/lXdwrCHINC0bcVT2UZ1Zbumi9U3sotR7lxz7/lyuBCCIifQ0
	eayTarN31y2Vm55LQu/pfrshEr+aOi3M2l9JiZBUyzjb6maAADnqMqkH0=
X-Google-Smtp-Source: AGHT+IFV47nEd3y7SLfstE9Tps7Y92mxwql0nKOJI4//bjaoh6qrj9/i3RasuyIXbhKn1fqIXAQigA==
X-Received: by 2002:a17:903:947:b0:290:9332:eebd with SMTP id d9443c01a7336-29b6be8c682mr183970255ad.10.1764103281161;
        Tue, 25 Nov 2025 12:41:21 -0800 (PST)
Received: from ?IPV6:2405:201:31:d869:2a74:b29f:f7bf:865c? ([2405:201:31:d869:2a74:b29f:f7bf:865c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2809b6sm176030905ad.76.2025.11.25.12.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 12:41:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------cdEetcsmS6OAIzPxepPAn7h1"
Message-ID: <9a2b03dc-acd0-467d-a4e6-feb5cf6165f9@gmail.com>
Date: Wed, 26 Nov 2025 02:11:08 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <69260883.a70a0220.d98e3.00b5.GAE@google.com>
Subject: Re: [syzbot] [net?] [can?] KMSAN: uninit-value in em_canid_match
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <69260883.a70a0220.d98e3.00b5.GAE@google.com>

This is a multi-part message in MIME format.
--------------cdEetcsmS6OAIzPxepPAn7h1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

--------------cdEetcsmS6OAIzPxepPAn7h1
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-net-sched-em_canid-add-length-check-before-reading-C.patch"
Content-Disposition: attachment;
 filename*0="0001-net-sched-em_canid-add-length-check-before-reading-C.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxMzcwODZmMjVjOGFhNTJlNDIyMjM1NTM0NWU0MjE4ZTQxMDE4OGM1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogV2VkLCAyNiBOb3YgMjAyNSAwMjowNjo1MSArMDUzMApTdWJqZWN0
OiBbUEFUQ0hdIG5ldC9zY2hlZDogZW1fY2FuaWQ6IGFkZCBsZW5ndGggY2hlY2sgYmVmb3Jl
IHJlYWRpbmcgQ0FOIElECgpBZGQgYSBjaGVjayB0byB2ZXJpZnkgdGhhdCB0aGUgc2tiIGhh
cyBhdCBsZWFzdCBzaXplb2YoY2FuaWRfdCkgYnl0ZXMKYmVmb3JlIHJlYWRpbmcgdGhlIENB
TiBJRCBmcm9tIHNrYi0+ZGF0YS4gVGhpcyBwcmV2ZW50cyByZWFkaW5nCnVuaW5pdGlhbGl6
ZWQgbWVtb3J5IHdoZW4gcHJvY2Vzc2luZyBtYWxmb3JtZWQgcGFja2V0cyB0aGF0IGRvbid0
CmNvbnRhaW4gYSB2YWxpZCBDQU4gZnJhbWUuCgpSZXBvcnRlZC1ieTogc3l6Ym90KzVkODI2
OWExZTA5OTI3OTE1MmJjQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KQ2xvc2VzOiBodHRw
czovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9NWQ4MjY5YTFlMDk5Mjc5MTUy
YmMKRml4ZXM6IGYwNTdiYmI2ZjllZCAoIm5ldDogZW1fY2FuaWQ6IEVtYXRjaCBydWxlIHRv
IG1hdGNoIENBTiBmcmFtZXMgYWNjb3JkaW5nIHRvIHRoZWlyIGlkZW50aWZpZXJzIikKU2ln
bmVkLW9mZi1ieTogU2hhdXJ5YSBSYW5lIDxzc3JhbmVfYjIzQGVlLnZqdGkuYWMuaW4+Ci0t
LQogbmV0L3NjaGVkL2VtX2NhbmlkLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9lbV9jYW5pZC5jIGIvbmV0L3Nj
aGVkL2VtX2NhbmlkLmMKaW5kZXggNTMzN2JjNDYyNzU1Li5hOWI2Y2FiNzBmZjEgMTAwNjQ0
Ci0tLSBhL25ldC9zY2hlZC9lbV9jYW5pZC5jCisrKyBiL25ldC9zY2hlZC9lbV9jYW5pZC5j
CkBAIC05OSw2ICs5OSw5IEBAIHN0YXRpYyBpbnQgZW1fY2FuaWRfbWF0Y2goc3RydWN0IHNr
X2J1ZmYgKnNrYiwgc3RydWN0IHRjZl9lbWF0Y2ggKm0sCiAJaW50IGk7CiAJY29uc3Qgc3Ry
dWN0IGNhbl9maWx0ZXIgKmxwOwogCisJaWYgKHNrYi0+bGVuIDwgc2l6ZW9mKGNhbmlkX3Qp
KQorCQlyZXR1cm4gMDsKKwogCWNhbl9pZCA9IGVtX2NhbmlkX2dldF9pZChza2IpOwogCiAJ
aWYgKGNhbl9pZCAmIENBTl9FRkZfRkxBRykgewotLSAKMi4zNC4xCgo=

--------------cdEetcsmS6OAIzPxepPAn7h1--

