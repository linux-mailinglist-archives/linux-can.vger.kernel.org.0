Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33857116980
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 10:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLIJhq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 04:37:46 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24075 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfLIJhq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 04:37:46 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191209093743epoutp03ab2dc1910babd32839f634fa380cb768~eqmNV5pJJ0984009840epoutp03d
        for <linux-can@vger.kernel.org>; Mon,  9 Dec 2019 09:37:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191209093743epoutp03ab2dc1910babd32839f634fa380cb768~eqmNV5pJJ0984009840epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575884263;
        bh=ykL/4DRhr1C70vkR6ePT1Qe0hOguBX4lFk/xQXzePiU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=PWzTLgIqa/cSGFGXpZGK65O3/JubcWBs/STK58BeNe9GgVhfM3TOB9cOXhiX/txTp
         hqoaGhBLm1U7GeOALyMF6/8v9zaLFS9Kb0mRKHGgHfh3Jj+cmptqIJNVcdLdGar8NP
         55aS9emXnbMaYKNletdIBWVqxpeONQEpATymWN8Y=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20191209093742epcas5p13ca4e91bfd33bb93934b8fd2816d4ede~eqmMh--_O0221702217epcas5p1R;
        Mon,  9 Dec 2019 09:37:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.01.19629.6E51EED5; Mon,  9 Dec 2019 18:37:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191209093742epcas5p21becb9d78825e6ef8962ae1de8519b8f~eqmMQ0IAA2401024010epcas5p2V;
        Mon,  9 Dec 2019 09:37:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191209093742epsmtrp2344939fb91b675c3c5c7bf2f20d5147b~eqmMQMlT_2254922549epsmtrp2I;
        Mon,  9 Dec 2019 09:37:42 +0000 (GMT)
X-AuditID: b6c32a4b-345ff70000014cad-56-5dee15e6d2aa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.47.10238.5E51EED5; Mon,  9 Dec 2019 18:37:41 +0900 (KST)
Received: from sriramdash03 (unknown [107.111.85.29]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191209093741epsmtip2ad997d96287345bee22b157bb61023aa~eqmLQuPP00744407444epsmtip2V;
        Mon,  9 Dec 2019 09:37:40 +0000 (GMT)
From:   "Sriram Dash" <sriram.dash@samsung.com>
To:     "'Sean Nyekjaer'" <sean@geanix.com>
Cc:     <martin@geanix.com>, <pankj.sharma@samsung.com>,
        <mkl@pengutronix.de>, <dmurphy@ti.com>, <linux-can@vger.kernel.org>
In-Reply-To: <20191209091449.909319-1-sean@geanix.com>
Subject: RE: [PATCH] can: m_can: remove double clearing of clock stop
 request bit
Date:   Mon, 9 Dec 2019 15:07:39 +0530
Message-ID: <019301d5ae74$4d9b4b40$e8d1e1c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHMOGk0HUmUTIdV2Tae95ai9VUhMwJDm23ap7JYZWA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7bCmuu4z0XexBvP/Cll0n97CarHq+1Rm
        iwnHFrJZrF80hcViedd9Zov3p16xObB59Jx7y+7R/9fAo2/LKkaP4ze2M3l83iQXwBrFZZOS
        mpNZllqkb5fAlXFr92qWgh+cFf3NN1gaGH+ydzFyckgImEjcfDYHzBYS2M0ocX89WxcjF5D9
        iVFi4cb9rBDON0aJFZ1T2GA6nvVcZILo2MsosabPGaLoFaPE51X7mUESbAK6EmdvNIE1iAio
        S+w7cwrMZhaokli4fg/YOk4BM4lL03cygtjCAsESN2/NButlEVCR2Nb2GWwBr4ClxKz5y9gh
        bEGJkzOfsEDMkZfY/nYOM8RBChI/ny5jhdhlJdF6/CYTRI24xNGfPcwgx0kIvGaTeL7lONQH
        LhIrD51igbCFJV4d3wINCymJz+/2QtVkS1zuew61oERixquFUPX2EgeuzAGyOYAWaEqs36UP
        sYtPovf3EyaQsIQAr0RHmxBEtarEq9uboaZLSxxYe5oJwvaQePRpI8sERsVZSD6bheSzWUg+
        mIWwbAEjyypGydSC4tz01GLTAuO81HK94sTc4tK8dL3k/NxNjODEo+W9g3HTOZ9DjAIcjEo8
        vJwFb2OFWBPLiitzDzFKcDArifAumfgqVog3JbGyKrUoP76oNCe1+BCjNAeLkjjvJNarMUIC
        6YklqdmpqQWpRTBZJg5OqQZG1e/GRbd8A/ga19h0r7zzO4f18pJEwRXXpRlkvweJfdWLyi6y
        cn6tdtsoq/7a5X3TnxfLpurFm/Q/38dqY19r+NzH5ZLDlOwFf/44TDNInSZzpX/TBa+eNV/K
        qzRfaujwdt86+XgXu1PxzL4DUr3T5s24vfyOWvBdng8iXb08yarMCkHsToeUWIozEg21mIuK
        EwG7n6LEOAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXveZ6LtYgyXMFt2nt7BarPo+ldli
        wrGFbBbrF01hsVjedZ/Z4v2pV2wObB49596ye/T/NfDo27KK0eP4je1MHp83yQWwRnHZpKTm
        ZJalFunbJXBl3Nq9mqXgB2dFf/MNlgbGn+xdjJwcEgImEs96LjJ1MXJxCAnsZpS4ufoaaxcj
        B1BCWuLnXV2IGmGJlf+es0PUvGCUmDjpABNIgk1AV+LsjSY2EFtEQF1i35lTbCBFzAINjBK7
        LuxghOhoZ5RY8ucJM0gVp4CZxKXpOxlBNggLBErM+a4CEmYRUJHY1vYZbCivgKXErPnL2CFs
        QYmTM5+wgJQzC+hJtG1kBAkzC8hLbH87hxniOAWJn0+XsULcYCXRevwmE0SNuMTRnz3MExiF
        ZyGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4erQ0dzBe
        XhJ/iFGAg1GJh7fC5m2sEGtiWXFl7iFGCQ5mJRHeJRNfxQrxpiRWVqUW5ccXleakFh9ilOZg
        URLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAuMRgXejVzfHLttTrPGpYsG61j3mZnF+l072Z
        rSaLRMLvhn6U1Z4xS5WXM97ywpJDZ17oHP0TsiR64zKVtnkan8+232Z851efGe15o72ooUVk
        RlGcX0vv7qeRIeLCZgHL1nsUa5w3vsmxyaLthlrV+t3626WVLL5YhnzIv3XtoN/vw5xvuhKV
        lViKMxINtZiLihMBbIvyypoCAAA=
X-CMS-MailID: 20191209093742epcas5p21becb9d78825e6ef8962ae1de8519b8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191209091507epcas5p4f54c5c836c7fb84039ad540808820d21
References: <CGME20191209091507epcas5p4f54c5c836c7fb84039ad540808820d21@epcas5p4.samsung.com>
        <20191209091449.909319-1-sean@geanix.com>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> From: linux-can-owner@vger.kernel.org <linux-can-
> owner@vger.kernel.org> On Behalf Of Sean Nyekjaer
> Sent: 09 December 2019 14:45
> Subject: [PATCH] can: m_can: remove double clearing of clock stop request
> bit
> 
> In m_can_config_endisable the CSA bit cleared 2 times while enabling
> configuration mode.
> 
> According to the datasheet:
> If a Read-Modify-Write operation is performed in Standby mode a CSR = 1
> will be read back but a 0 should be written to it.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Acked-by: Sriram Dash <sriram.dash@samsung.com>

> ---
>  drivers/net/can/m_can/m_can.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c
> b/drivers/net/can/m_can/m_can.c index 02c5795b7393..4edc6f6e5165
> 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -380,10 +380,6 @@ void m_can_config_endisable(struct
> m_can_classdev *cdev, bool enable)
>  		cccr &= ~CCCR_CSR;
> 
>  	if (enable) {
> -		/* Clear the Clock stop request if it was set */
> -		if (cccr & CCCR_CSR)
> -			cccr &= ~CCCR_CSR;
> -
>  		/* enable m_can configuration */
>  		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT);
>  		udelay(5);
> --
> 2.24.0


