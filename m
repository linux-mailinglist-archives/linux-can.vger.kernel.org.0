Return-Path: <linux-can+bounces-3950-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEFFAFA58D
	for <lists+linux-can@lfdr.de>; Sun,  6 Jul 2025 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63834189BD73
	for <lists+linux-can@lfdr.de>; Sun,  6 Jul 2025 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F93202987;
	Sun,  6 Jul 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Y7+aJgt2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="d3ZIdrZI"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7C225390
	for <linux-can@vger.kernel.org>; Sun,  6 Jul 2025 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751809087; cv=pass; b=I9tkq61iKk5iHfwFJoTdd+ErBlrfbcRwGqtqzJAh0zmfr+V2tBE9UhBB1EeeBlRkJFfaXHhaQQq3cYyInPg3owIchurthqpSmcpPmxTJMTnh7W+Tf1AF9kDtVb5GKIkR4QgEow3W6nw//+M6/F4Fj2G4yJNfuG4jfDAxLIpkBfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751809087; c=relaxed/simple;
	bh=1g3+nUnHEow1LGdx0NWOtYNIAB99uC7lOtPAGiymt4Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Q0jJiz5ShTCm5J2vmDpHsOmelzcCaapPZdrSGUmiU+i18EzKYT1kQNg4EPehXz9mh4T/ce961qar9sy4xKUcC4WcUlDfMo6fAHxAZIsZeR3Uo4BzVzpetUTqhkvpVlh2J6xTwxn0AJ7st2i415lh954GP6xBT56u5vZZi46GImA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Y7+aJgt2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=d3ZIdrZI; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1751809078; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=p06mAFsTncQxrkoivuvj2SCYu3M07BICejSgbB3HwAmOKcK4D2elG7ef1e3l7mae+P
    /6/hJXFlODN0C26bKWEZkM/3laOYNQjRk/852uo8EpJDbaOcPIjLZDMYaalz2nITGELJ
    gsndckHHNGPqhxoMCClSNOknOuO2JUYq1EABba6//GIRCi0MNbkIXVKxg5VQnjTyn4Ot
    cCogBAvsSmUdZBPpKZlw08dDw1ON6O4LrYCbqpaXgRHtwbmLwoK5uj+KfUOKVQjaV9Ir
    qTfLwKQIIYB8ZTWtvT/rDpMWKVwokuW9ZH+b9DpP4cpaihedHCzrEoEScKgWdN1eABgh
    v9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751809078;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=OQUj6i4Z0zJjgGrri5zbOBPoQnnpJ5lIxh1kqV5O9NQ=;
    b=mi35z+RUxOxIBgz8kde4ZK/49DzonApGL0FEbg+vOAk/+RKN2YAes8Y3pGPBmIlkmZ
    PntanEvdZd1NNBAeZNlWRphNpGJbU3YBv4IbWEnP/m+ptjIgXttvkczEa7WjwWL4F4Pf
    HjZyQdBoGjpyAO8G7fl+W/lC7DWCFJWT4WL8GHnfNqNJ7JnKnALN4W9eeNXd8cHjo2q9
    MDf7OjcefcAxQDPZPA2e4k/U2wPEACyzckamfzoh+ttFY57gt9FfdrY9BtXO/hFMmtys
    P5rzb5q31VMLuG5aOF/n8EsV/woc35sxpTGPAz0oRx+zbTpcCmMBDIZ3BSppK+ze9OfR
    uNSg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751809078;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=OQUj6i4Z0zJjgGrri5zbOBPoQnnpJ5lIxh1kqV5O9NQ=;
    b=Y7+aJgt2Ioreh4NOQfs+DO+ewF3Xr/UsOW3+VXTShXeQD3+6N/VatecajxlL60tnKm
    3cPWju+vTkJn2cFRjWHBAqjUgkiWloFtkw22CviMX/JZmxOfC3Zo+IRrVBbfByjtqixp
    cJYBa1nrAbre/OajoqqtlFE9cO8WoXQWL3CbBsyQRD1rMapLRHiOEfB3xNU33dqwm6Y4
    fnxu0q6jp6y1JwFxZvqnEka8Hx59TkOMn6MVyexcIhVQgibvxH0q6V29nWd4shqOUARq
    DFDghufkAUKX3O0FHVl7SyGeWY1iapQ0nbiMlyxx6uGzp70Dfmy2tRMgndlyIU0tQBKt
    ZZfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751809078;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=OQUj6i4Z0zJjgGrri5zbOBPoQnnpJ5lIxh1kqV5O9NQ=;
    b=d3ZIdrZIK20wbea/65Q52xXPwtCw+VrBEPp7T5CFu6VqWkFATRxFOtHSyJw4BQjOpI
    7TEfFmCLave5JjVt5OBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K55aa3166DbwK24
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 6 Jul 2025 15:37:58 +0200 (CEST)
Message-ID: <3a0ea8a8-510b-48b2-85e2-f2e892768163@hartkopp.net>
Date: Sun, 6 Jul 2025 15:37:42 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: CAN XL status
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello all,

I've posted two updates for Vincents XL dummy driver for the can-next/b4 
tree that shows more/all relevant information (including the PWM settings).

The dmesg output can be seen at the end of this mail.

Currently I see two potential changes:

Rename CAN_CTRLMODE_XL_TRX to CAN_CTRLMODE_XL_TMS where TMS would mean 
to enable the Transceiver Mode Switching instead of telling we have a 
CAN XL Transceiver.

The other is the ideas from Stéphane to reduce to options to configure 
the PWM values, when they are not calculated automatically.
This leads to the question if we need some

CAN_CTRLMODE_XL_PWM_AUTO (default)
CAN_CTRLMODE_XL_PWM_MANUAL

??

@Vincent: Can you share your current thoughts/code so that we can meet 
the current net-next window? I fell that Stéphane is currently blocked 
to release the CAN XL capable PEAK Linux driver which should support the 
netlink API from day one.

Best regards,
Oliver


[ 7617.955889] can0: dummyxl OK
[ 7641.099210] can0:
[ 7641.099226] can0: CAN control mode/supported : 00009A20/0001FF22
[ 7641.099235] can0: Enabled modes: fd tdc-mode-auto xl xltdc-mode-auto 
xltrx
[ 7641.099241] can0:
[ 7641.099246] can0: CAN clock:       160000000 Hz
[ 7641.099252] can0: CAN max bitrate:  20000000 BPS
[ 7641.099257] can0:
[ 7641.099262] can0: CAN CC nominal bittiming:
[ 7641.099267] can0: 	bitrate: 500000
[ 7641.099273] can0: 	sample_point: 0.875
[ 7641.099278] can0: 	tq: 12
[ 7641.099284] can0: 	prop_seg: 69
[ 7641.099289] can0: 	phase_seg1: 70
[ 7641.099294] can0: 	phase_seg2: 20
[ 7641.099299] can0: 	sjw: 10
[ 7641.099304] can0: 	brp: 2
[ 7641.099309] can0:
[ 7641.099314] can0: CAN FD databittiming:
[ 7641.099319] can0: 	bitrate: 2000000
[ 7641.099324] can0: 	sample_point: 0.750
[ 7641.099329] can0: 	tq: 6
[ 7641.099335] can0: 	prop_seg: 29
[ 7641.099340] can0: 	phase_seg1: 30
[ 7641.099345] can0: 	phase_seg2: 20
[ 7641.099350] can0: 	sjw: 10
[ 7641.099355] can0: 	brp: 1
[ 7641.099360] can0: 	CAN FD TDC:
[ 7641.099365] can0: 		tdcv: 0
[ 7641.099370] can0: 		tdco: 0
[ 7641.099375] can0: 		tdcf: 0
[ 7641.099380] can0:
[ 7641.099384] can0: CAN XL databittiming:
[ 7641.099389] can0: 	bitrate: 8000000
[ 7641.099394] can0: 	sample_point: 0.750
[ 7641.099399] can0: 	tq: 6
[ 7641.099404] can0: 	prop_seg: 7
[ 7641.099409] can0: 	phase_seg1: 7
[ 7641.099414] can0: 	phase_seg2: 5
[ 7641.099419] can0: 	sjw: 2
[ 7641.099424] can0: 	brp: 1
[ 7641.099429] can0: 	CAN XL TDC:
[ 7641.099434] can0: 		tdcv: 0
[ 7641.099439] can0: 		tdco: 0
[ 7641.099453] can0: 		tdcf: 0
[ 7641.099458] can0: 	CAN XL PWM:
[ 7641.099463] can0: 		pwmo: 0
[ 7641.099468] can0: 		pwml: 12
[ 7641.099473] can0: 		pwms: 4
[ 7641.099478] can0:
[ 7641.099491] can0: dummyxl is up


