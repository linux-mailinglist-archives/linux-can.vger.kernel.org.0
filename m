Return-Path: <linux-can+bounces-3461-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64438A99C35
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 01:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F5F3A6649
	for <lists+linux-can@lfdr.de>; Wed, 23 Apr 2025 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64521FF24;
	Wed, 23 Apr 2025 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b="qcJDsqns"
X-Original-To: linux-can@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0BC2701BF
	for <linux-can@vger.kernel.org>; Wed, 23 Apr 2025 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452124; cv=none; b=goKd4fAZr64c0G5lT0WBJAMCZb8wnkjnYqPD+vZvzsAQeKEplz5E93pR1xw8gnsuAnhonCl/IFghOmw1L9pApZ0NjH6JXWqNuWy6r9mw8zM53KY8veTh/XfXn1TPvunGqYJ+FaH0nGDnEShoKu842EysKNKcDBZxRw2/wkd24yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452124; c=relaxed/simple;
	bh=nY8Ec7TyYf45yUwF6fz8FOV9Q9YbdPpCXDnWhrTsUuo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=ubbn+xvMRqPKHN+BSARLQM8T2diuTgd+vC+DTZIpPFFiy2tZZ6MA3I5GZ2gT/y/KFVOtBHFjS3ph23u83hiQGH4+VavYdnTWoffv/4BcU6GIaHy/WlJ/ABECKTZRbvU86X89onjAlACaFP/bKUQig23581bTFnEC7dILq/FRQeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com; spf=pass smtp.mailfrom=vpprocess.com; dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b=qcJDsqns; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vpprocess.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpprocess.com;
	s=key1; t=1745452119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nY8Ec7TyYf45yUwF6fz8FOV9Q9YbdPpCXDnWhrTsUuo=;
	b=qcJDsqnsLF9b1CskbH6eTZuJ9m8xkdTt1tqsyX0YaHKMuuD3SfOZtIb1TIlWrEtNndHT+6
	gNfA3uoBcAp1Ik/541O2Ssf/+aLbGlhv8KoMSVttaGV6b116xwDuU6q0DDY9oxb8mnchpw
	69YFI0z9AyJ+rNhmoyoSEPCj1YSG0MXy2TG18J0asApB8rPWjLTze7o/sF/LIVkzqhMQcr
	r7qKeKg8FgQoNq6HhnPuVcq3fNRE6TN7HPOyf5Jp3qsccOAWppbto93oLKKty45ZdnFKCc
	45wtoPfq0ieUQjcPNAVzog/v+wGrR/7DtHIOG64ZjSJ/NUgR8Slh8GK9QnDo7A==
From: Kelsey Maes <kelsey@vpprocess.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: mcp251xfd: forced TDC
Message-Id: <C2121586-C87F-4B23-A933-845362C29CA1@vpprocess.com>
Date: Wed, 23 Apr 2025 16:48:23 -0700
To: linux-can@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

Hello,

I have a custom board attached to a Raspberry Pi using a MCP2518FD and a =
40MHz clock. I have a problem where I get a bus-off condition when using =
bit rates that use a DBRP > 1.=20

Here is a reproduction method:

1. In config.txt:
[all]
dtoverlay=3Dmcp251xfd,spi0-0,interrupt=3D25,rx_interrupt=3D24

2. Run the following commands:
sudo ip link set can0 type can sample-point 0.875 bitrate 125000 =
dsample-point 0.875 dbitrate 500000 fd on berr-reporting on restart-ms =
100
sudo ethtool -C can0 rx-usecs-irq 10000 rx-frames-irq 8 tx-usecs-irq =
10000 tx-frames-irq 2
sudo ip link set can0 up
cansend can0 00000000##1.00.00

3. Observe the bus-off condition in dmesg.

This also happens for 250 / 1000 but works for 500 / 2000 and 1000 / =
4000.

I have tested a hack where TDC is disabled if DBRP > 1 in =
mcp251xfd_set_bittiming() and this fixes the issue, though I=E2=80=99m =
not sure it=E2=80=99s the right fix in the long run.
TDC should probably be controlled from userspace somehow as its usage is =
highly dependent on external factors.

Any feedback or assistance is greatly appreciated.

--
Kelsey Maes
VP Process Inc.





