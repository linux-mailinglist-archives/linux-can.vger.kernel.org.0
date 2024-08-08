Return-Path: <linux-can+bounces-1175-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502494BC22
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 13:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E470E1F217D0
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB31891AC;
	Thu,  8 Aug 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D2YO23hM"
X-Original-To: linux-can@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E212C7FD;
	Thu,  8 Aug 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116093; cv=none; b=GCQOhE5t1aIQNcenFWQf3Ttn/7Mpy5Bkphmd94AxTLRdkF/HR9kvqu9sPiFFLVCDHcVToZWVUJuePmc1RxREbrwpPzVNtN9+Gd1LRuwTPinIJBO8RZ1NWMBr3NHZt3YvgrEs8rn1KrIn5tlPw0/0d3yH3wQDlmC9Jw5tRC02cc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116093; c=relaxed/simple;
	bh=WvKLrbLPtyPdz8DsDfZEWTqHSa/FHwwozHbEKXfZA+w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=t/Undp9Vd7Xo9IBHrlh62FfUYOp/AAX2jq6S6olauQU1SgZdIAXC57PhX852WWSTR5WmXaoxfaCfvhpIdlIjg/9HSihnoZWVPQ3Gb3LI7B4kINzClmQeeMc+nCpNoUOGgBgUlECJE8Dyg0SlbJ7+oW7KBr8labs/hOob+kLaKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D2YO23hM; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723116083; bh=mciiCE8n/RMJG+duOZ5Cgc6TInq3o/PUTzIa4pY+guI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D2YO23hMjcoCDogAWPVYR+snmvdBz6VHGj46ilxV0jJF7huuTfX/f2Mvz3a1dKZ12
	 dDoDjbO4NCN+VORdF10g/ERhgXFXjm55aZlV5+i8PztSiSQhHB8oGafSHsusce8Vtr
	 /Qssjcy7iDmJz1iXAkEcalbv/Ar02CblLPxK8uZ0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 200226FF; Thu, 08 Aug 2024 19:08:00 +0800
X-QQ-mid: xmsmtpt1723115280t566hic8d
Message-ID: <tencent_5B8967E03C7737A897DA36604A8A75DB7709@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1juxRMfdrWAiJwNzMYX353FdSsj78E7OkuZFUn3hi5/W6fI+4SLR
	 l9rv3pQWiKGVuMBpkmXs0AsaC+YF6Cwjkfc2n1cvkhTCsox2O+x72jpQzngZOiEhHKMWjIZDjgcn
	 cjXiV+Yua+FU8rd6LOV4yOZdSTU3xf68DYWW1fY5mN8JhpaId12vg0oN8NeRbx9z4hMnImA053ot
	 hdVlkJOrxp6CjUej3yI1pdjRONLNnHKgN/wHlJ+nfTfRg1ztZHna1LPCBTQFuTy4XuqQArNHgq9x
	 kVTpAFuLI5cHdQU81EiSet1IxX3NWGYr2nf0mNn0zVzl2y+98xrjmbwa1ppL8JOB7nQVppOSnQv/
	 gaZqD+sueV/ZILAcEc9zUgzksE23ibega473tXglEPdqo2vqxsjYn7ehfoEO3KXXmEm5bWgw1+ut
	 1O0GzJJICUYUzExKMt8VIISlQfaUg6t3IlZFf4ObLxI07BqYpeKXvmTe0Qe70F9z8iNq8kRERbxx
	 5yx9fVF1XRZYD/TpfYmRDF2BkT9jJrA2f0z6xXF0LCw3xU1HsOsdRqjhImqUAj35nlcIToqTYV7j
	 gFvBwwDw4rfbPKDtejKfH8d/2d1vyrDourR7eWzBazGfuAu4/hdmn2ybxTNTenPKMPjJTz/mCsoi
	 w/HvqKskDLpbA8g3hW6cGpDWY42BCT00oq/W0j4mx+K7cFCajr6eodcdW1LGRxbh2SInh7mk1kbr
	 rI8GVv4a/KKsh8wECOwiqWitmu+jW9MQQOv0T604od25QIdBVkwF2fPITUV07KMST/nik5Mj7/Ww
	 VluLOWvn5gJK4d4UgTlggk9PH8FIFzel1C9ZSV7eWGy80/hEC/aUehYszew5yCIoH2x3sO6nth8V
	 UHS9xv0wtbSBJHxik8z/rcGuf199cZngXhCZ36Wl6L9ztnt+J86uqamXRzwp+9v83No2o53JFbv2
	 +UxMgVGR5mCBO7pWLARiE0+riyzdHup5ww12JhDKw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: o.rempel@pengutronix.de
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kernel@pengutronix.de,
	kuba@kernel.org,
	leitao@debian.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robin@protonic.nl,
	socketcan@hartkopp.net,
	syzbot+ad601904231505ad6617@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] can: j1939: fix uaf warning in j1939_session_destroy
Date: Thu,  8 Aug 2024 19:07:55 +0800
X-OQ-MSGID: <20240808110754.1276329-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZrR4fsTgDud3Uyo0@pengutronix.de>
References: <ZrR4fsTgDud3Uyo0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 8 Aug 2024 09:49:18 +0200, Oleksij Rempel wrote:
> > the skb to the queue and increase the skb reference count through it.
> > 
> > Reported-and-tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> This patch breaks j1939.
> The issue can be reproduced by running following commands:
I tried to reproduce the problem using the following command, but was 
unsuccessful. Prompt me to install j1939cat and j1939acd, and there are
some other errors.

Can you share the logs from when you reproduced the problem?
> git clone git@github.com:linux-can/can-tests.git
> cd can-tests/j1939/
> ip link add type vcan
> ip l s dev vcan0 up
> ./run_all.sh vcan0 vcan0

BR,

--
Edward


