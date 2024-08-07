Return-Path: <linux-can+bounces-1166-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A2A94A9D9
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630EC2888F9
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BB578C68;
	Wed,  7 Aug 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXTMXc5S"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAB6A8C1;
	Wed,  7 Aug 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040217; cv=none; b=RMW/YAf5zVBmIHRPsjrwyYjiNBhQGdQo3Wq+q0ZYwyi+0NoHzHrxkZS/1U3cxaiX3VKBtd2RmmQP+NU2vamLfthPNGjlZvwks5hdhLADradZWoOKz4Wqowj5XiYUi1zKsgdfC2WmIQSLhEil/gwcaGKNgGX6po4gSjUsyUS/uO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040217; c=relaxed/simple;
	bh=RY7pundmmFAKtYwafjDNDNGWaxDEriX5V506WBUuJso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYQZ2hJRR2+0iNWRQjyxAuDkuv5jD8W96pq5Ov/84XMQKh5Hp4NutxT2rbHP9TTL2Sdfl8OrfogmAVM5+40d8NDXctsVKL4OljbkBx1vV9FRqpTDa8d9N4j61jYmp0nzZdzuChUCU9lAgroFGFZEr8qpzsuDojt7isrjJ3xYEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXTMXc5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4BFC32782;
	Wed,  7 Aug 2024 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723040217;
	bh=RY7pundmmFAKtYwafjDNDNGWaxDEriX5V506WBUuJso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MXTMXc5Sr2PhIv5TnIOAJOI4rMlM+Dkfr+LJ7WlP2AcaJOyvVFgzKBzDbRPzSTr8P
	 iRGU9AnPLRUYyzs2uQil7gpyRpt278gropdnax+78JvFYxEFcAHjAljVYFMK7pzA0/
	 9WPXL3XVTLnSRDyxhEZ+RxCSrPUV+dxgPEcXgHVQ6lrkhGvfuHMEHB78a5U9K/tWH3
	 CrIhiUROJSlJgh1NffYfykxeiPf2aXK30D7H5SXZRHqXefuWaTMK0DIiURCtDSHvlF
	 wwlkAlMp6UmD2/XxbwwJ4zaGO90Vwe//RR61dL9H5Do0cUi5LQNeL1u1f5OVJnyE0i
	 LKjqlB7+rWkNQ==
Date: Wed, 7 Aug 2024 07:16:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de,
 leitao@debian.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de,
 pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next] can: j1939: fix uaf in j1939_session_destroy
Message-ID: <20240807071655.5b230108@kernel.org>
In-Reply-To: <tencent_BB8B66363CC7375A97D436964A80745F7709@qq.com>
References: <000000000000af9991061ef63774@google.com>
	<tencent_BB8B66363CC7375A97D436964A80745F7709@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 20:35:47 +0800 Edward Adam Davis wrote:
> Fixes: c9c0ee5f20c5 ("net: skbuff: Skip early return in skb_unref when debugging")

Definitely not where the _bug_ was added, as Breno said.
It is kinda tempting to annotate somehow that this commit helped catch
the bug, tho. Not sure how.

