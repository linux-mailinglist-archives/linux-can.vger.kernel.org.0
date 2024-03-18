Return-Path: <linux-can+bounces-406-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B487F047
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 20:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862F5280F96
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 19:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D7B55E63;
	Mon, 18 Mar 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ERIdZPKr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="4b6xLfQ6"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAEE5645C
	for <linux-can@vger.kernel.org>; Mon, 18 Mar 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789349; cv=pass; b=q2fznv2EOEzrx8Fy8cKvyMUS9SlYk76EJUp1q6pIEZeF/gzrNUIqGpMBtKBsMQAFIZ89fixpeUYHC7yHwQ3xOZwEYYzWrHW742E5A5Annj2/75ncigBCbd2VKIMByoSD1HtP0AAah9kPIpUbpT3c7y1JtaP3pl1/kQhFHz94tfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789349; c=relaxed/simple;
	bh=FV77+wJzWK8BkyBMJGTudy5cNFoqNv0wxfgwLUYnp2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgxbx5rdUjo5MoFO0dftEE9Y5oC19SUHJnqTdo8LGq/LeJK/danmaCPYZFO5lcDS88QopX+rJJiDI6ISeU/C+OXDp2ojvHUGtQG8L8k57zAWfX+c87tBCufJWWOwFHB/e7kzz6o7lyBvdQG97xtkouaG6JFp9mOB3XndaXCkbmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ERIdZPKr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=4b6xLfQ6; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1710789338; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XVHFSytETOWIkTMtITef6UpefUZIbLGYggNo8iBlVM9A9lTgEJWzuMYOvYGTneQrBx
    +Tgu4xlE6wMc9qsyeGVzskyJ4aT1vXoqavZKvJ1BBUWHRiex/7Kceh7oFPWdzDl2VPlu
    HxNYS075uCLMRwFNxdMBpqbS4yUc2PGWD03JWf8dQUlNhb8kpYYF06Spo8IzXr8S45eX
    rBw0BEYDvH8GfvrfoEiwi1Ml0ICh1Maut2k28uwONvL4QHQ6wvtM4Fj+meu4m/zGdUK6
    JBL0sLRl/zk/MZZrBc5pSuueOGhd6yK9u2x4f35mUwD7v79T5JWiESdOt26nzj/V9S7T
    mLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710789338;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=s1MD1Cj1v0SHmTVc7T17Hh2jQdNQKe26OOKFVbhk47s=;
    b=Lx2UNScA1LSA5kn9nuK4eyT8DNUUUw8FbRa7YlQgirZeMff6APd/daIL4uYbcq4mfK
    R8DZ/RhGx5STiGgzB8jj9noCQHUpjVC9nOYh5yx+0vxpVgrnhDmkN0zTey3b85HMVV8N
    gakq4BuXHjdZi1pS5rTA/q0yLZMCpI9+tfmR1YHDeqXZO9ga6m/A8O3uVsiW87BaDIaf
    H7DzC+4FloRgJxSv9TJ94o/lrjfhbJwnUBQK1AALX0U0ENO7D2wTlWowHXWqy5Ouy5FP
    gjDrLVNgOCdy6RewqnTQp/BIjsbelN9Pxxow4vrZU0coU9xsnul+1ntoGGDfuq86DIXF
    SfsA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710789338;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=s1MD1Cj1v0SHmTVc7T17Hh2jQdNQKe26OOKFVbhk47s=;
    b=ERIdZPKrcPl63Wryg1PKQLP3jhNu6UL15eRGJm77BTid1ezjmOIA7ZkKwLxFEuPxGQ
    3oq5lksWzQh6q7RYl76nbdlGYd+rLjKnAdJetodetGnYe5rmNwC4TYk699/TNPytT56y
    CL2SqZfnzlyHy/xiIaRMFShenshc6TOSmig7Guc5hUBcMGNTdJdObjRm+RhHOeSP23LR
    8nvROrLxKgEgL0GNJa8O7hvLoaj7WtBli6MP6WqeMxNP9dNRanl+ZIt1aamVdgfQwa+z
    lCuv3bQKl7bdd2LNIuxO0ur5vkys3gC26/W8x3guw/OBKnrL6/EHC8OlT6P+QSR+mMYS
    MNYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710789338;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=s1MD1Cj1v0SHmTVc7T17Hh2jQdNQKe26OOKFVbhk47s=;
    b=4b6xLfQ68XpS4sV6HyROjOQNpXWKzoeNbzIwebPZqLFQzHPkBT1rlDhOJdCHEApWP4
    8r3h5LhchNb/spadpUAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDdAnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::90c]
    by smtp.strato.de (RZmta 50.2.2 AUTH)
    with ESMTPSA id K0cc6102IJFcAEU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Mar 2024 20:15:38 +0100 (CET)
Message-ID: <0860439d-7810-438b-b532-54b517e2a0cd@hartkopp.net>
Date: Mon, 18 Mar 2024 20:15:32 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Wireshark-dev] [PATCH 0/4] Wireshark SocketCAN updates
To: Gerald Combs <gerald@wireshark.org>,
 Developer support list for Wireshark <wireshark-dev@wireshark.org>,
 Guy Harris <gharris@sonic.net>
Cc: linux-can@vger.kernel.org
References: <20240318104643.24098-1-socketcan@hartkopp.net>
 <09952070-5182-4d63-bb2b-0cf6cfe2053d@wireshark.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <09952070-5182-4d63-bb2b-0cf6cfe2053d@wireshark.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gerald,

thanks for the pointer and the excellent documentation!!
That was a 10 minutes job:

https://gitlab.com/wireshark/wireshark/-/merge_requests/14886

I assumed the Wireshark development process taking place on the mailing 
list - but GitLab is even better. Happy review ;-)

Many thanks and best regards,
Oliver

On 2024-03-18 17:37, Gerald Combs wrote:
> Thanks for your contribution! Can you submit a merge request at
> 
> https://gitlab.com/wireshark/wireshark/ ?
> 
> Complete documentation on contributing code to Wireshark can be found in 
> our Developer's Guide at
> 
> https://www.wireshark.org/docs/wsdg_html/#ChSrcContribute
> 
> On 3/18/24 3:46 AM, Oliver Hartkopp via Wireshark-dev wrote:
>> This patchset simplifies the CAN packet type detection as it focusses
>> on the rules to distiguish the different CAN CC/FD/XL frames from the
>> Linux kernel API.
>>
>> Additionally some more content is shown in the dissector and the
>> CAN CiA 611-1 definitions have been cleaned up and extended by CiA.
>>
>> Oliver Hartkopp (4):
>>    socketcan: simplify CAN packet type detection
>>    socketcan: display CANFD_FDF and CANXL_XLF flag content
>>    socketcan: display len8dlc content for Classical CAN
>>    socketcan: update CAN CiA 611-1 definitions
>>
>>   epan/dissectors/packet-socketcan.c | 86 ++++++++++--------------------
>>   epan/dissectors/packet-socketcan.h | 17 +++---
>>   2 files changed, 39 insertions(+), 64 deletions(-)
>>
> 

