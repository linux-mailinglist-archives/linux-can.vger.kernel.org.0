Return-Path: <linux-can+bounces-7327-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fz9DLcZz2nDswYAu9opvQ
	(envelope-from <linux-can+bounces-7327-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 03:36:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C95390142
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 03:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27AB7300D777
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2026 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563643126D7;
	Fri,  3 Apr 2026 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="V5TagMBX"
X-Original-To: linux-can@vger.kernel.org
Received: from out30-77.freemail.mail.aliyun.com (out30-77.freemail.mail.aliyun.com [115.124.30.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998EF2BEC2E;
	Fri,  3 Apr 2026 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180212; cv=none; b=cdc7oop/ArDUR02uao6Njd975/V5OUcCRxBo7osekAGGOHQcx+Z3U1WdV4S7k9MtHQjlhpaBrJ3/7hKRgPbZTNurR/l6shBsXAf3qX3PEnRp30NnbOQ7vi6YuKV+1mA0Vm5mJvsj+/WsiILiT1rATMb8hSzvqvwcjzzRZRVK864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180212; c=relaxed/simple;
	bh=3UlQUXohPcHx8bCT0GFHwpyFjdqqgBWDwDu2BFi7bpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlBiq3989MHZj0XWX1e2ML47PxFbCK/bPeK2LL541fhZiM+nUJNEFSzzYY1qG8TI7Mp+8TJKeVSwgFDWeCNaJN0n85dl7A/SAoTJUJ7KdcmjvL8+0EhFQ58xSDXMMhhSstLFVe7DvI9HwascxKSu1/W/Z+teAQiJmeWadMWcECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=V5TagMBX; arc=none smtp.client-ip=115.124.30.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1775180208; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ockn+jvkuSlSNE4lv805KDH+XFcuR/bMHKoEQtnOM9E=;
	b=V5TagMBXREPhK43GwDDJzi3j1bSQnfwFrh0Pn29GPDK3hZD3XEQbn+DF4jARl96IF36FGOPxSRTMZmYGwbY4omtnYxpQu9e/IEAouwrWgQE2hs+647h7JxpKr4NTW85SAGV1W/T8HEvAzXv3Km9VXLUf7v8ZDnYA8GI5L9D7uTE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1394434|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00419711-0.00030944-0.995493;FP=14518894585905662907|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---0X0IU014_1775180205;
Received: from Ubuntu24(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X0IU014_1775180205 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 09:36:48 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: mkl@pengutronix.de,
	linux-can@vger.kernel.org,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 5.15.y v2 0/3] Backport to fix CVE-2026-23031 in 5.15
Date: Fri,  3 Apr 2026 09:36:12 +0800
Message-ID: <20260403013615.4641-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[aliyun.com];
	TAGGED_FROM(0.00)[bounces-7327-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[aliyun.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruohanlan@aliyun.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,vger.kernel.org,aliyun.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C7C95390142
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v1->v2: Append the following two commits suggested by Marc Kleine-Budde
mkl@pengutronix.de, thank you. :
79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error")
494fc029f662 ("can: gs_usb: gs_usb_receive_bulk_callback(): fix error message")

Marc Kleine-Budde (3):
  can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak
  can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on
    usb_submit_urb() error
  can: gs_usb: gs_usb_receive_bulk_callback(): fix error message

 drivers/net/can/usb/gs_usb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.43.0


