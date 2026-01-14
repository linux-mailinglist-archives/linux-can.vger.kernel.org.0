Return-Path: <linux-can+bounces-6152-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4619DD21544
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 22:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D643301E6D3
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 21:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1259A285041;
	Wed, 14 Jan 2026 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="0oWRm4WD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="oTWbPQLv"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5CD357A2D
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426014; cv=pass; b=i8CYswmSG50mSuAxpdwY7VpG5ss4EosIKrKtUpHT7vxKo9uzJ66wP21SO9MHwYBuf6TenTKH7o2ytwqje6722QisHrnT2DZKPzZozObBm4tTccICq3pgOK3jjCRApiPqgzz3G8hlSIn4zFwguIYInSP+6Ni23qTipN4EvBYmGvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426014; c=relaxed/simple;
	bh=KzXdWwH+9+D8PnE6pliunqNT2ijvf60c5nH3YnFqS34=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cYiIPKw5shvFsWUP3PiToFcWlWwi3QbA0lU7WyhorvCVFce2e2icouOT9qNGMBVjE1OH7jP+BwkugJhjdFOIWcYvBD5GYW+VBcwkwESUda7Pp+TkDB4QpWpnvJdLJKHnxcc81ZCSYVzhzTDoXYneWmd1QTuu7lQT97BMRotk944=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=0oWRm4WD; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=oTWbPQLv; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-0c7t.prod.antispam.mailspamprotection.com; s=arckey; t=1768426012;
	 b=NzQ/YypLX0yjHYjG10m8JQcZAW6BaCc/WXELMeAJjKdx77otgYGkiDmRbhxMrf/2y+/GChxZqU
	  DIXDf8xsP6U5qhQ62hYtBm6Sje0sHX6JJq9pAhzOatyxLU2sVscqetrtksxIKfPVpjhdQpraPE
	  /L2RCLH1WDQR6DlXMqHtW8MoXmIwxygFlkRCwGHgG7ENeWYF+hempTDFOB8QomW5J07IPAtz++
	  BS+GJQtejniMXuaK+FzTzbQujgJMkUuOWyHtWdl+gORwY6Bq98NTSN+pWg+yTANKNAZ2t1T4LM
	  NmeLmRThYpu6n0JjB1R31FgZxvKG8VaBDjQ96v9UAZKyzQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-0c7t.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-0c7t.prod.antispam.mailspamprotection.com; s=arckey; t=1768426012;
	bh=KzXdWwH+9+D8PnE6pliunqNT2ijvf60c5nH3YnFqS34=;
	h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:DKIM-Signature:
	  DKIM-Signature;
	b=UVay2iDwTu+J0/hrpG3EdyochTEF/O+qDzqmUrTosPQI0EGGNhDIdYJJrFUl5+HHDm5T/G5yOv
	  FfJx7+8lTF4TluWdOpneXRIAEdnotlEh7NoxNI5kUnZALqM3TvPFUe/AchOOYUlM1cP+z0haoq
	  jF0NZJn7c1hfldiMvpNw7pPOiNO6B8MvXWu1c1m2h58KXVd2KM/AgT6NWfWG/h++DPgssq4RNi
	  pnDlL/axD3r8mZQpN4vrQY2DuIR//rYthliywmKmpGldRNbJi8gO/njLjDmGRB+kdkmY/F9yRk
	  l8BJTUmwHpi9irH0SgYh7So01i1Y5SsLYrwOqvDFKguMYg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=KzXdWwH+9+D8PnE6pliunqNT2ijvf60c5nH3YnFqS34=; b=0oWRm4WD/3a21K6jdKLoU6a+LA
	iiK8DQ/U/at8EXNcCEsyi9te7dDxikTu0HjNU6eQ/J97hVQBo8BAxOnOQNdN9kkfAl9/7aC+ZYCRD
	Ycvl3r5xkmUOOAi2jHlrrRz0L7vnTyTBtphigOhx+7IeqOkWP565a4Zihe7RO0QD99l4=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-0c7t.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vg8O7-00000001uzw-3tqy
	for linux-can@vger.kernel.org;
	Wed, 14 Jan 2026 21:26:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:To:From:Date:cc:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=KzXdWwH+9+D8PnE6pliunqNT2ijvf60c5nH3YnFqS34=; b=oTWbPQLvOih/pBq7fSiZ2DCM1V
	vq5x8nB/73cIhy4D3efyoOdotfVDPX1UkmDxEUh54qNrlCEsmNcnaX+Qf50QbEd1XjdnIe5AjryWU
	nTV3JAT1H1T+d/+9yhuVMr8J4EvhN2OPpnS8jT43nvnq45Zg7LOd7jX80E3V5LNnquT4=;
Received: from [95.248.141.113] (port=62416 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <francesco@valla.it>)
	id 1vg8O1-00000000AlG-1PrL
	for linux-can@vger.kernel.org;
	Wed, 14 Jan 2026 21:26:41 +0000
Date: Wed, 14 Jan 2026 22:26:39 +0100
From: Francesco Valla <francesco@valla.it>
To: linux-can@vger.kernel.org
Subject: [QUESTION] How to support partial networking
Message-ID: <aWgKD8AG-C9YlFRe@bywater>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 905a72da7acaab83b2f961de68e1f7b8
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vg8O7-00000001uzw-3tqy-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-0c7t.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello linux-can,

I am starting to develop a driver for the TJA1465 SIC CAN transceiver
from NXP [0], which among other things supports partial networking, and
I was wondering whether it has already been discussed or not how to
support such a feature.

For those not familiar, partial networking is an automotive-oriented
feature that allows to wake-up selectively through CAN traffic some ECUs
while leaving others in a quiescent state. This can be used for example
for periodic maintenance tasks, diagnostics or updates. It is typically
implemented inside a trasceiver, which is always powered and stores in
a volatile memory a list of CAN IDs (plus masks, much like the SocketCAN
filtering works) that shall lead to the wake-up of the ECU.

In the context of the Linux kernel, this can be probably be implemented
in a number of ways:

 - as a device-specifc capability (accessible e.g. through sysfs)
 - at phy level
 - in the generic CAN subsystem
 - ?

I did not find a previous discussion neither in the mailing list nor in
public presentations, but maybe some discussion already took place
privately or I missed something.

Any idea or preference? If not, I'll try to come up with a proposal and
submit an RFC.

[0] https://www.nxp.com/products/TJA1465

Thank you in advance!

Regards,
Francesco


