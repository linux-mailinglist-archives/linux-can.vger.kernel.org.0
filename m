Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C274D3293C9
	for <lists+linux-can@lfdr.de>; Mon,  1 Mar 2021 22:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbhCAVfx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Mar 2021 16:35:53 -0500
Received: from mxwn13.webd.pl ([194.181.228.67]:32832 "EHLO mxwn13.webd.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240989AbhCAVcF (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 1 Mar 2021 16:32:05 -0500
Received: from wn13.int.webd ([192.168.101.113] helo=wn13.webd.pl)
        by mta01.webd.pl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <mariusz.madej@xtrack.com>)
        id 1lGq8O-0007y7-Sb; Mon, 01 Mar 2021 22:31:20 +0100
Received: from [192.168.101.231] (port=56654 helo=mta01.int.webd)
        by wn13.webd.pl with esmtp (Exim 4.93)
        (envelope-from <mariusz.madej@xtrack.com>)
        id 1lGq8O-0007xT-QB; Mon, 01 Mar 2021 22:31:20 +0100
X-Quarantine-ID: <E4sbbMchn9DT>
X-Virus-Scanned: amavisd-new at mxwn13.webd.pl
Received: from wn13.webd.pl ([192.168.101.113])
        by mta01.int.webd (mxwn13.webd.pl [192.168.101.200]) (amavisd-new, port 10134)
        with ESMTP id E4sbbMchn9DT; Mon,  1 Mar 2021 22:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xtrack.com;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QIgReb5zRoOpUPVJyihwqxW00SA1y59k9VlSCzA0rN8=; b=ICz80VJe2H0W93tDVTYCS3k/Nb
        1b0k1OtPsAlXLD2UGCNVz3Eumf37hmLoHbDcc8A1TVoxalE7X8TA77qVbcZ5EGjyFpCp0ZfPWEE1u
        LVoE3l0Ilu3ZE3G89oqzAh9zu/4+9HQoId3zINCCiIbkfseW2wb2riFc3SSYC1zoz8tNywC3EK/Gz
        d4ZnLxUcaSJKkENdstiCn9CFHEBai1G8QpyC5YnafZuOkEFICNOuD/KsvwL9oEviPwIbdMyybhgmp
        4aB+LuhLkXWmxWMg50+Hey5eF1o0Q2IkLWerencW3b80vhkn3JRQrBnKHrVMHAPUo/0NJwTd7p+mH
        Yy4iFODg==;
Received: from [185.241.198.130] (port=62483 helo=[192.168.32.4])
        by wn13.webd.pl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mariusz.madej@xtrack.com>)
        id 1lGq8O-0000Sb-Gf; Mon, 01 Mar 2021 22:31:20 +0100
Subject: Re: m_can: a lot of 'Rx FIFO 0 Message Lost' in dmesg
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <PR3PR05MB7212376CDA795770B7E625E6809F9@PR3PR05MB7212.eurprd05.prod.outlook.com>
 <20210226133702.echxlob5z4pj5ptc@bigthink>
 <d0ebed81-3f7a-1e82-e16b-85e242d1ddca@xtrack.com>
 <20210301141406.bnrqqkbfnq523ofb@bigthink>
From:   Mariusz Madej <mariusz.madej@xtrack.com>
Message-ID: <0b1e3e50-8189-9976-2b6b-7a4ab84c1af2@xtrack.com>
Date:   Mon, 1 Mar 2021 22:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210301141406.bnrqqkbfnq523ofb@bigthink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 3/1/21 3:14 PM, Torin Cooper-Bennun wrote:

> Thank you Mariusz, you've helped me understand this driver better - I
> had missed some of the logic. I agree that this is a bug.

Thank You for your feedback. I am glad we could help each other.

> Your fix makes sense to me. If you submit a patch to the linux-can list,
> it will probably be reviewed quickly. (Don't bother to CC Dan Murphy
> though, as his address listed in MAINTAINERS bounces mail.)
>
I just send a patch. We will see.

Regards,
Mariusz

