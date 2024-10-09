Return-Path: <linux-can+bounces-1617-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C18B9961B5
	for <lists+linux-can@lfdr.de>; Wed,  9 Oct 2024 10:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55F41F21E3E
	for <lists+linux-can@lfdr.de>; Wed,  9 Oct 2024 08:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92013A409;
	Wed,  9 Oct 2024 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gLmeJezB";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mSDpFUXX"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446A2F46
	for <linux-can@vger.kernel.org>; Wed,  9 Oct 2024 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461023; cv=pass; b=dI0cbHH5/r94vjF56K7oW84p0t8cEYE2Bya1ocSEqrPz7cZxk5/jrIdUE7mJ2/KTi5t5Ugfy6sAl8j0MBu286mkSaYoL98fMeJpT97c5e8P+qMabPFuAah/bD67X9MRvoUzb6lhngokPUCQMBz0OukayXf2tursTjW4eXtmvDdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461023; c=relaxed/simple;
	bh=sAEB3Oy7Yq+8crfNsSl/FM32xQVn+AFesUM9ASmeVJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jSMOXbum6fdAw0QoGf13Y0nc2NADoQ+7uuyeCHIqSMCaJk+4B9gMsULbncVMozvViJW4d19KRYGIWt3WIskVRlnjdRQ5E59AZdVOA+8JYVrPm3eg71UT9MNrI8dkMF+0/2qJmUo+jpHURzGzF37iTnB/ehEpOO1lAAnuzvzYa+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gLmeJezB; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mSDpFUXX; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1728459569; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VDGaHfMjnOKMy+R3/JqgUIKe99UPXBfMTjgURqnVQjUiSl5Ml7R4LtkNc2JZDutr5g
    x9S3+x/UrXdUkBBnOlB1rItbyeYTF+2ZHk5bU4Uat+k8WtRl3z/+PeQodrlZriLAXW9s
    wZhZhkNKwWVVJHgejSy57YcdVX6gFjXkCzux2PPQYEMnrTN0owbKShlFBfGHWdlHUd1f
    Jhb7GAd3u0QcdFlDZtHuCVvm/9FzVQ0mPJXd8+UTeYHQfeix6I7T7FD4WZmgJQ+uf81z
    Le1buuptUXyDCrzkrX6XJ+VpfQmIE2S28EAZkxyeNTgMyQ6M1X+2MfBcK1pOx8W0o79x
    y2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728459569;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=h/eYjxcg71o92jxzq4aC8YNg5ox17xg4KY9B9830eJI=;
    b=Az3covEfCZ0UHSNpYSW89rPgLBbXBkfhNKKbZBzrQg5uCZtkCuKX4rm6BxXdlP1llH
    6W117mxGCs8Hg+ioz9JdRZ6j8SldsokFL+1gF3Tipemma3sfwxcsnvzAYpW4xSN9F84G
    ud6H0TgseW0dHJY43LzaEwGJAlHovWbGmG8dSkjgZIEv8mXPAmmFgJjysBH2GJZvvqEx
    W5qBlDj2hQ+4FCe2x1QBIIv5Vslo+2dO94p3bXCiqkHlwoFNEXrJucHvsc3akA+uXXiY
    x1oh4UiLpVZRhcgO+RennReZKjJT8URFvpR4w+yTKf1LOsc+tM8j5pdMmdsPxFdiUN38
    9Mhg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728459569;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=h/eYjxcg71o92jxzq4aC8YNg5ox17xg4KY9B9830eJI=;
    b=gLmeJezBowbB+DMtGSPKfcmYSo9kQP5/dv6Mjo1EM2cH2ofUuwIT1rFwbnux4K33+d
    8t1C13kjotnZNBEKDhWIL5jrzRYm5b4Cim32C2HWJhcmaxQB72Vo6l0qlAMZlNRFXXYr
    ccFraZDgCes3defwATgW+0w8XwehcNQj2cTDfiM4ViUxBACVRiiSf1p0WP/km04nXkj4
    KEiztqgpeADOX6W7ll5guC3nIAmqo4kHt8g3N5MP718sXNLTbQdj253B4RyS4nlf5oZ7
    E/S4U7MeSSxqBK5QUn5tAMNbOv60cy0JTc1dQXDmcRYgyj0HWhkK+ruqfcbEgWBQgXmi
    vFMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728459569;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=h/eYjxcg71o92jxzq4aC8YNg5ox17xg4KY9B9830eJI=;
    b=mSDpFUXXyrDjL5MdiLjz1FrTkn4dJ71+Hi/2B4ETHvgDLsnYGS0KseQu83HoxVb64Z
    OU6lZZPNz6VBwNN6vQDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id Keb3f30997dSU1L
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 9 Oct 2024 09:39:28 +0200 (CEST)
Message-ID: <687db169-810b-45d0-a6b9-df76221c1a7a@hartkopp.net>
Date: Wed, 9 Oct 2024 09:39:22 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Predictable network device names for CAN devices
To: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>,
 linux-can@vger.kernel.org
References: <CAO7FjJE-opA-ZHSYOTAw1G1uWpX7Esqj-REid=RVccf_YKJ4vw@mail.gmail.com>
 <15A4B417-3B79-4AF2-8A8D-25ABDAD2A6FC@vanille.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <15A4B417-3B79-4AF2-8A8D-25ABDAD2A6FC@vanille.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.24 18:57, Dr. Michael 'Mickey' Lauer wrote:
>> Could someone provide some details on whether this works, if it is
>> possible another way, or if it is possible to submit a feature request
>> for a future kernel release?
> 
> Does it really need to be a kernel feature? It works fine here via udev rules.
> 

Same here. I'm using several PEAK USB FD (Pro) devices and CANdlelight 
(gs_usb) hardware. All of these have a device ID number that allows to 
rename them via UDEV rules.

Best regards,
Oliver

