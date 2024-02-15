Return-Path: <linux-can+bounces-270-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485D855817
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 01:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873251C20D02
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 00:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E040211C;
	Thu, 15 Feb 2024 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b="V6JbEW05"
X-Original-To: linux-can@vger.kernel.org
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C01C0F
	for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 00:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955403; cv=none; b=Cmj3n6kc/PknWelUZhPyLo4YDSuun4+dJYIbZNJaQNU7sPwcZDPYHMpmOAU3wv/DkqmlZy3pOLsfx+SoiPhnBQ7yepFcw0t3XgJKLu2cuSRMpX08KvJYbBoiAqbKNhhV2af6mFt9RbHJ1aGUeK/MvWcS/AnK6jFFRwjCfSY0sR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955403; c=relaxed/simple;
	bh=gx+60euxyJyuR88Ll/avFz2JfUHhZcyL9kFG64zl4UY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tt6qWtkTfzLnNAXEDZ4EEHdg4UozQIiRf/EMlm8/51zBx70sieYLdyRof+gCeADZQDa/mnHIquX1bMhwuJRmlkVQwWBDI38T+ur2c/FPbB37QXBQzAerRwkRV+XCKilKuwOGniVdh1R2GXeC/j7NhbpBCbtLvw+lcAJKW2Sssbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net; spf=pass smtp.mailfrom=sonic.net; dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b=V6JbEW05; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sonic.net
Received: from smtpclient.apple (173-228-4-48.dsl.dynamic.fusionbroadband.com [173.228.4.48])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 41F03AFM026919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Feb 2024 16:03:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonic.net; s=net23;
	t=1707955392; bh=ip42npypXtvTz2qX5yUDuwbGeKo98pGERxMkJItlyFo=;
	h=Mime-Version:Subject:From:Date:Message-Id:To:From:Subject;
	b=V6JbEW058bVYNZCtnAsSWaQian/HWbQRDB2R+98AZ5t+JOiPKZYxZX1vcSVqKvHbq
	 uELIP8GX/oEGMCxS98stTRZtqcPHKm0bsfWirioFO3q3ti40zbNqAkPAOpo9eT/0v4
	 RYo9YQtntf0LAKAiiM7A7zOW2Sjep5gqxZ9c5eNdp+ePud6fpTqDQKVd4hv5eudg74
	 bBXCUHKqzOXgNX0yGHg0OiCIzaHFpfQJgo0TBLtnVEnHhksP1cqT6swAI0SAgy3lb3
	 /6FxG5x2rWF9uWZTPjMVx4xMydQlbeLCte9YWiSxDAcXQEB/gBwDy/lCcLvxImNpBg
	 wF+0iAI+8zRPA==
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
In-Reply-To: <05ae1eca-4bb6-40e4-88fc-791cc2051da8@hartkopp.net>
Date: Wed, 14 Feb 2024 16:03:00 -0800
Cc: Developer support list for Wireshark <wireshark-dev@wireshark.org>,
        linux-can@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A92A0FA-D249-4445-867E-5B3838044AA2@sonic.net>
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
To: Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: Apple Mail (2.3731.700.6)
X-Sonic-CAuth: UmFuZG9tSVYI3EUyG1GxRzwG2q6k6EFyfGfH2YPiOrRtcgRxtkVfdZ9Z5xYjaaDZ5uZOQrsKjAWV3Hgtrc257rKApaZTwHya
X-Sonic-ID: C;/N87m5XL7hGzTCFnR+6Zsg== M;wP1tm5XL7hGzTCFnR+6Zsg==
X-Spam-Flag: No
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd

Wireshark 4.2.3, which includes the SocketCAN changes, has just been =
released.  Presumably, various packagers of Wireshark 4.2.x will pick it =
up at some point.=

