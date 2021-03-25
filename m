Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CAF348CF5
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 10:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhCYJbm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 25 Mar 2021 05:31:42 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:34854 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhCYJbY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 05:31:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D32176091866;
        Thu, 25 Mar 2021 10:31:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YoyBypuKW-2Y; Thu, 25 Mar 2021 10:31:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6724C606BA27;
        Thu, 25 Mar 2021 10:31:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nNY73BYUovkI; Thu, 25 Mar 2021 10:31:22 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 341BC6091866;
        Thu, 25 Mar 2021 10:31:22 +0100 (CET)
Date:   Thu, 25 Mar 2021 10:31:22 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Message-ID: <1257589994.113291.1616664682112.JavaMail.zimbra@nod.at>
In-Reply-To: <20210325081326.1652-1-socketcan@hartkopp.net>
References: <20210325081326.1652-1-socketcan@hartkopp.net>
Subject: Re: [PATCH v2] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: fix msg_namelen values depending on CAN_REQUIRED_SIZE
Thread-Index: pDS8WtNN2MR5oqZbFLSl28sy0Hyc2A==
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Oliver Hartkopp" <socketcan@hartkopp.net>
> An: "linux-can" <linux-can@vger.kernel.org>
> CC: "Oliver Hartkopp" <socketcan@hartkopp.net>, "richard" <richard@nod.at>, "Kurt Van Dijck"
> <dev.kurt@vandijck-laurijssen.be>
> Gesendet: Donnerstag, 25. März 2021 09:13:26
> Betreff: [PATCH v2] [RFC] can: fix msg_namelen values depending on CAN_REQUIRED_SIZE

> Since commit f5223e9eee65 ("can: extend sockaddr_can to include j1939
> members") the sockaddr_can has been extended in size and a new
> CAN_REQUIRED_SIZE macro has been introduced to calculate the protocol
> specific needed size.
> 
> The ABI for the msg_name and msg_namelen has not been adapted to the
> new CAN_REQUIRED_SIZE macro for the other CAN protocols which leads
> to a problem when an existing binary reads the (increased)
> struct sockaddr_can in msg_name.
> 
> Fixes: f5223e9eee65 ("can: extend sockaddr_can to include j1939 members")
> Link:
> https://lore.kernel.org/linux-can/1135648123.112255.1616613706554.JavaMail.zimbra@nod.at/T/#t
> Reported-by: Richard Weinberger <richard@nod.at>
> Suggested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
> net/can/bcm.c   | 10 ++++++----
> net/can/isotp.c | 11 +++++++----
> net/can/raw.c   | 14 ++++++++------
> 3 files changed, 21 insertions(+), 14 deletions(-)

The patch unbreaks my application. :-)

Tested-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
