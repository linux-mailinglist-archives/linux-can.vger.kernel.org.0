Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF32348478
	for <lists+linux-can@lfdr.de>; Wed, 24 Mar 2021 23:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhCXWUA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 24 Mar 2021 18:20:00 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:52742 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhCXWTs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 18:19:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7F8F1606BA2E;
        Wed, 24 Mar 2021 23:19:47 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aAdTPbDUwl1H; Wed, 24 Mar 2021 23:19:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2E269608F463;
        Wed, 24 Mar 2021 23:19:47 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CUU7GZNnGyff; Wed, 24 Mar 2021 23:19:47 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0B501606BA2E;
        Wed, 24 Mar 2021 23:19:47 +0100 (CET)
Date:   Wed, 24 Mar 2021 23:19:46 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Message-ID: <224900630.112641.1616624386963.JavaMail.zimbra@nod.at>
In-Reply-To: <20210324215442.44537-1-socketcan@hartkopp.net>
References: <20210324215442.44537-1-socketcan@hartkopp.net>
Subject: Re: [PATCH] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: fix msg_namelen values depending on CAN_REQUIRED_SIZE
Thread-Index: xtiRlWxa0xrv1bYDayz6sW4ggI97dg==
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Oliver,

----- Ursprüngliche Mail -----
> @@ -808,10 +810,13 @@ static int raw_recvmsg(struct socket *sock, struct msghdr
> *msg, size_t size,
> 	int noblock;
> 
> 	noblock = flags & MSG_DONTWAIT;
> 	flags &= ~MSG_DONTWAIT;
> 
> +	if (msg->msg_name && msg->msg_namelen < RAW_MIN_NAMELEN)
> +		return -EINVAL;
> +

Like with Kurt's patch, my test fails here too because msg->msg_namelen is 0.
->msg_namelen is always 0 in the recvfrom() case.

Thanks,
//richard
