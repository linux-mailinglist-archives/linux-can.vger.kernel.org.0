Return-Path: <linux-can+bounces-163-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C5683C79F
	for <lists+linux-can@lfdr.de>; Thu, 25 Jan 2024 17:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201DE293704
	for <lists+linux-can@lfdr.de>; Thu, 25 Jan 2024 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961012AAC4;
	Thu, 25 Jan 2024 16:11:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-relay232.hrz.tu-darmstadt.de (mail-relay232.hrz.tu-darmstadt.de [130.83.156.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5112A174
	for <linux-can@vger.kernel.org>; Thu, 25 Jan 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.83.156.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199117; cv=none; b=BPGyQtCF65ErlQvs5vOaAPnQRRlk1cPj/86ZqfPvgbE0LHaCayTMDh5AoHnYV+csJZ0BI3mua33frEByQNff52PvI5XlZvIQTUTTR9lxFVz1uWkBQCjBBJhBRec3B31Rb+dfsliyE3DlOTljRdHeu33m11+0mK1Op3Ohnackqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199117; c=relaxed/simple;
	bh=kwR/UA+2iMP3zcIApLgIL49L3tt/jF6pEbhLqsv2Ajw=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Subject; b=ovdhpx3J86XZWg4pIeIVLg3jdYSV3qu5TnMz3l3UOD/10OzfCUnyL8y4EygQK6Dgk/7COrfMGngYucoMaBfUW3VHS6f4LsEbbdBB+6/VAuo/u9vFXYPOCcXR1TLbPNvb3o/YzxIQmJ1h/a8ji7whNfWUBoxdjcL4t4f9TvSQVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elektron.ikp.physik.tu-darmstadt.de; spf=none smtp.mailfrom=elektron.ikp.physik.tu-darmstadt.de; arc=none smtp.client-ip=130.83.156.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elektron.ikp.physik.tu-darmstadt.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=elektron.ikp.physik.tu-darmstadt.de
Received: from elektron.ikp.physik.tu-darmstadt.de (elektron.ikp.physik.tu-darmstadt.de [130.83.133.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail-relay232.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4TLQnF6N10z43qg
	for <linux-can@vger.kernel.org>; Thu, 25 Jan 2024 17:11:45 +0100 (CET)
Received: from hertz (hertz.ikp.physik.tu-darmstadt.de [130.83.133.204])
	by elektron.ikp.physik.tu-darmstadt.de (Postfix) with ESMTP id 8DEE4100B22
	for <linux-can@vger.kernel.org>; Thu, 25 Jan 2024 17:11:45 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26034.34881.283564.969697@gargle.gargle.HOWL>
Date: Thu, 25 Jan 2024 17:11:45 +0100
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
To: linux-can@vger.kernel.org
Subject: SLCAN and systemd
X-Mailer: VM 8.2.0b under 27.2 (x86_64-suse-linux-gnu)
X-Header-TUDa: <kZXe8fALxyVqcg48SLoqB5ZhX07lR00hdUjdhpOGmYgXAWgew0ls8JAtjLdAr5Cf85dLaUcKvWnx4rQFD3yFWneF3K63vv5ZdRT.1706199106>

Hello,

can anybody help to set up an SLCAN adapter via systemd?

By hand and for the given adapter I can do
slcand -o -s8 -t hw -S 3000000 \
/dev/serial/by-id/usb-Black_Sphere_Technologies_Black_Magic_Probe_STLINK-V3_v1.7.1-353-gbb84e8ec_004100483038510D34333935-if06

and

ip link set up slcan

and it works as expected. However automativ setup at plug would be fine.

Thanks
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 1623569 ------- Fax. 06151 1623305 ---------

