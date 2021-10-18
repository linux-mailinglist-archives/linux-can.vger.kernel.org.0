Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD9F430E0F
	for <lists+linux-can@lfdr.de>; Mon, 18 Oct 2021 05:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhJRDJK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Oct 2021 23:09:10 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25162 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhJRDJJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Oct 2021 23:09:09 -0400
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HXhZL5lJJz1DHfP;
        Mon, 18 Oct 2021 11:05:14 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 dggeml757-chm.china.huawei.com (10.1.199.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 18 Oct 2021 11:06:57 +0800
Subject: Re: [PATCH] can: j1939: j1939_session_deactivate(): fix potential UAF
 access
To:     Marc Kleine-Budde <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     Xiaochen Zou <xzou017@ucr.edu>,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20211017120158.2024996-1-mkl@pengutronix.de>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <6d784d3f-2eae-8569-0266-47142ffe5d1f@huawei.com>
Date:   Mon, 18 Oct 2021 11:06:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211017120158.2024996-1-mkl@pengutronix.de>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeml757-chm.china.huawei.com (10.1.199.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> From: Xiaochen Zou <xzou017@ucr.edu>
> 
> Both session and session->priv may be freed in
> j1939_session_deactivate_locked(). It leads to potential UAF read and
> write in j1939_session_list_unlock(). The free chain is:
> 
> | j1939_session_deactivate_locked() ->
> | j1939_session_put() ->
> | __j1939_session_release() ->
> | j1939_session_destroy()
> 
> To fix this bug, move the j1939_session_put() behind
> j1939_session_deactivate_locked(), and guard it with a check of active
> since the session would be freed only if active is true.
> 
> Link: https://lore.kernel.org/all/CAE1SXrv3Ouwt4Y9NEWGi0WO701w1YP1ruMSxraZr4PZTGsUZgg@mail.gmail.com
> Link: https://lore.kernel.org/all/aa64ef28-35d8-9deb-2756-8080296b7e3e@ucr.edu
> Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Xiaochen Zou <xzou017@ucr.edu>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
> 
> I picked up the patch from Xiaochen Zou. I think it is the proposed
> fix for:
> 
> | https://syzkaller.appspot.com/bug?extid=a47537d3964ef6c874e1
> 
> 
> It turned out that
> 
> | 0c71437dd50d can: j1939: j1939_session_deactivate(): clarify lifetime of session object                                                                                                                                                                         
> 
> is wrong, and should be removed, as Ziyang Xuan proposed in:
> 
> | https://lore.kernel.org/all/20210906094200.95868-1-william.xuanziyang@huawei.com
> 
> Ziyang Xuan, Oleksij, can you have a look at Xiaochen Zou's patch and
> give me an Ack, then I'll take both patches upstream.
> 
> regards,
> Marc

I think the session kref >= 2 when it is active state. The j1939_session_put() in
j1939_session_deactivate_locked() will not trigger __j1939_session_release() to free
session.

0c71437dd50d ("can: j1939: j1939_session_deactivate(): clarify lifetime of session object") just
only partly wrong. j1939_session_deactivate() is called not only when session is active, it may be
called when session is not active already.

And I think the 0c71437dd50d may be the real fix for:
https://syzkaller.appspot.com/bug?extid=a47537d3964ef6c874e1

I can not find an exact scenario as Xiaochen Zou's patch mentioned. So I can not agree.

Or can you give an exact scenario @Xiaochen Zou.

Thank you!

> 
> net/can/j1939/transport.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index dc3c30810833..35530b09c84f 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1072,7 +1072,6 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
>  
>  		list_del_init(&session->active_session_list_entry);
>  		session->state = J1939_SESSION_DONE;
> -		j1939_session_put(session);
>  	}
>  
>  	return active;
> @@ -1086,6 +1085,8 @@ static bool j1939_session_deactivate(struct j1939_session *session)
>  	j1939_session_list_lock(priv);
>  	active = j1939_session_deactivate_locked(session);
>  	j1939_session_list_unlock(priv);
> +	if (active)
> +		j1939_session_put(session);
>  
>  	return active;
>  }
> @@ -2152,6 +2153,7 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
>  int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
>  {
>  	struct j1939_session *session, *saved;
> +	bool active;
>  
>  	netdev_dbg(priv->ndev, "%s, sk: %p\n", __func__, sk);
>  	j1939_session_list_lock(priv);
> @@ -2165,7 +2167,9 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
>  				j1939_session_put(session);
>  
>  			session->err = ESHUTDOWN;
> -			j1939_session_deactivate_locked(session);
> +			active = j1939_session_deactivate_locked(session);
> +			if (active)
> +				j1939_session_put(session);
>  		}
>  	}
>  	j1939_session_list_unlock(priv);
> 
