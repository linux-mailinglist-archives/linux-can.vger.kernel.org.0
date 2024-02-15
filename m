Return-Path: <linux-can+bounces-272-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EECE8560E9
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 12:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79642B39C91
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557412B175;
	Thu, 15 Feb 2024 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b="Wm/EtgiJ"
X-Original-To: linux-can@vger.kernel.org
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F4692FF
	for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993801; cv=none; b=jWtvKKF3IyIrA2vq78atJwEFZtgdc7vmOQVDNIwIgLlqBnkz4ZpABHdpXXSw1TAGd4fvjLiiK74zp2OY6zJi9IS3YivYPyXxAdAu0LyKYecJxySrnSU18aLC6DBVajSLKYlZv1jjVaMJ9KTtqbMy7gglDEJ9q9OnGYBx1I16PRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993801; c=relaxed/simple;
	bh=GMkzGxjPNmHoPGKBQVj7Y4Ck9BwJCm2SvbkuG+pthBs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UeYZV7aQoz68FK1apiJ7/I8SvryoCpUWKz8d4EZMFChLrSTUfqIITko/I6Rb0mXgSm5QcdEO1WFmVRm2kdy6h4gaWEJZ5G2+jrlktu7+jQOgsWePgzWrLmBljgla0itB7agSaD828IwlE83lCxDqmZQQ6NbH4vd2FAFFj14cBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net; spf=pass smtp.mailfrom=sonic.net; dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b=Wm/EtgiJ; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sonic.net
Received: from smtpclient.apple (173-228-4-48.dsl.dynamic.fusionbroadband.com [173.228.4.48])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 41FAhEns020826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 02:43:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonic.net; s=net23;
	t=1707993796; bh=GMkzGxjPNmHoPGKBQVj7Y4Ck9BwJCm2SvbkuG+pthBs=;
	h=Mime-Version:Subject:From:Date:Message-Id:To:From:Subject;
	b=Wm/EtgiJ/4sUZD3WVbVRDXVlRcVj59bvyH4utAoUg+WM6btAnfeTkkwxJVuAqSNx0
	 h3W1hp88akXsKmONUjs06ObJkkkiqSqA0xmIkaJ8/r/zxTlIMa/730HdCSbZggTpiE
	 syzq33k5QSp+7ShC/ogHGpQ4JWM5Cs5au7/77Zcb+S34IdX0LxxW2dm/9a0OzO/8FO
	 FtSpFU10J4za2VEVXUYY4Hys6ZeeEXXFaHw4udPdeeL35OTSHkU+1RNqLdLCXs3Lxg
	 DIjXpe1HiOZU/h/YAqbRCpMQipqKUXGO9RDl6JaBcx0KN2Sj32IXFCe6WxVxFhK+/g
	 r6g2Vblugc89Q==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [Wireshark-dev] SocketCAN Support is broken in latest
 Wireshark-v4.3.0rc0-1430-g600de02805d0
From: Guy Harris <gharris@sonic.net>
In-Reply-To: <6f86c5ca-3442-4287-bc40-315054a7684d@hartkopp.net>
Date: Thu, 15 Feb 2024 02:43:04 -0800
Cc: Developer support list for Wireshark <wireshark-dev@wireshark.org>,
        linux-can@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D27F6435-783D-4D84-B525-53B7FD58339F@sonic.net>
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
To: Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: Apple Mail (2.3731.700.6)
X-Sonic-CAuth: UmFuZG9tSVbWB7ZzIKWbu8G+5a5tDZyiLi/+yys3IY2cM35spi7+D/rBh5pLWG4UoZvksybkd1fdoV/RiP5cKuNg7GvOxxvr
X-Sonic-ID: C;+IpnBe/L7hGsECFnR+6Zsg== M;JomVBe/L7hGsECFnR+6Zsg==
X-Spam-Flag: No
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd

On Feb 15, 2024, at 12:01 AM, Oliver Hartkopp <socketcan@hartkopp.net> =
wrote:

> Marc created a pull-request for Linux mainline upstream (net-next) and =
the CAN XL VCID support will now show up in Linux 6.9:
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit=
/?id=3Dc83c22ec1493c0b7cc77327bedbd387e295872b6

How does one request that the VCID information be provided on a =
PF_PACKET socket (whether SOCK_RAW or SOCK_DGRAM)?


