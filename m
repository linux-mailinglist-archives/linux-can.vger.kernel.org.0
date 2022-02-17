Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B754BA07B
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 14:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbiBQM7d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 07:59:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiBQM7c (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 07:59:32 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7F28421A
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 04:59:17 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220217125913epoutp01e5040f79da002c353871ef3a433d9ba9~UlD0TfBM92903829038epoutp01S
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 12:59:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220217125913epoutp01e5040f79da002c353871ef3a433d9ba9~UlD0TfBM92903829038epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645102753;
        bh=WUe/PxK+ViffpPR/NHR/MSGiY8JOMj+EdSfu9jVhba4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=LmzV5FEKxMge4r6DzTVGvyWTXKksYgwyyNX+trWKfd0XB+BuN7MX1wMlO9zERsEiX
         qfCLqd4m9P24aiDn0KeBesTa44WgebHhEC7t4ufmEpfkB9jVP6vQ5rrTjZmoFkaJnm
         f2XIXtDdWP1VYROIoAaTLeHaDxCLNh1dHEt/j+pI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220217125913epcas5p3f2560ac79faf7e1655f0add12267e172~UlDzgHfo90748307483epcas5p3z;
        Thu, 17 Feb 2022 12:59:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JzvzH1wWkz4x9Pv; Thu, 17 Feb
        2022 12:59:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.90.06423.5964E026; Thu, 17 Feb 2022 21:59:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220217120929epcas5p15c7c581fd884f38cdf60054af8be7f99~UkYYy_Y1W2488624886epcas5p1o;
        Thu, 17 Feb 2022 12:09:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220217120929epsmtrp263f29419dcf07226f7a150cce4b03033~UkYYyR7bl3088430884epsmtrp2Z;
        Thu, 17 Feb 2022 12:09:29 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-27-620e46952b6a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.86.29871.9FA3E026; Thu, 17 Feb 2022 21:09:29 +0900 (KST)
Received: from rcsekar03 (unknown [107.122.12.252]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220217120928epsmtip23d09c2dff2558234a1f32466643973e6~UkYXsntbu0940809408epsmtip2T;
        Thu, 17 Feb 2022 12:09:28 +0000 (GMT)
From:   "Chandrasekar R" <rcsekar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
In-Reply-To: <3fb21251-a4de-2300-d1c6-5b98dd3c36d1@kernel.org>
Subject: RE: [PATCH net-next] dt-binding: can: m_can: list Chandrasekar
 Ramakrishnan as maintainer
Date:   Thu, 17 Feb 2022 17:39:26 +0530
Message-ID: <000801d823f7$36e98ec0$a4bcac40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQGhFcnq45mbRs5vPGdf8T8/1m7UQQJTW9qfAUoUomys6NYkEA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTXXeqG1+SQetGfYv5R86xWpw/v4Hd
        YtX3qcwW6xdNYbFo3XuE3YHVY9OqTjaP/r8GHp83yQUwR2XbZKQmpqQWKaTmJeenZOal2yp5
        B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBtVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ2x7+JO54JhAxf92gwbGd7xdjJwc
        EgImEou7fzB2MXJxCAnsZpS4tnwzlPOJUeJuwzYWCOcbo8Sb+dfYYVou909gA7GFBPYySixf
        lAZhv2CUWDDbFsRmE9CReN/3DaxGRKBCYv3yf2C9zAJuEjtuH2QGsTkF7CTuznrOCmILC6RI
        rLjQxQJiswioSqxZ/BjM5hWwlFh7cgs7hC0ocXLmExaIOdoSyxa+Zoa4R0Hi59NlrBBxcYmj
        P3uA4hxAe50k1p0IBrlfQuAru8TnK01Q97tInL6zEKpXWOLV8S1QcSmJz+/2skE0NDNK7D1y
        jQUiMYFRouuJAoRtL3HgyhwWkAXMApoS63fpQ4RlJaaeWscEcQOfRO/vJ0wQcV6JHfNgbEWJ
        aVtngrVKAN15ZF7IBEalWUg+m4Xks1lIvpmFsGwBI8sqRsnUguLc9NRi0wLDvNRyeGwn5+du
        YgSnRi3PHYx3H3zQO8TIxMF4iFGCg1lJhPfDQd4kId6UxMqq1KL8+KLSnNTiQ4ymwOCeyCwl
        mpwPTM55JfGGJpYGJmZmZiaWxmaGSuK8p9M3JAoJpCeWpGanphakFsH0MXFwSjUwxU3ubzjO
        Kvi14PZ/S61P+xbOjJZXZ5XpePdKKcBHfrZJ44VzsTKfO58dKI5levF1lz77/iJb7qcy6jpv
        8q/vWF8YX8umwrFE41nY0ZJ1Qaz37vGIZuz5tfX67c2KOvEmBze/WfAhP1DsVMeZGU9W5u+T
        88rYGBG/OvL8AnebbX+WC3Yncbd5MyytZKuYnpRoEvRygZO8hXfiRXnBLP6t0m2JxS2bGDf4
        59wT+Zy+O99Y7ZSF35bm9B/dbBoerMr/P09gVfglVPpKR3tB2pyCGIXVbv9nGlX+zwld47Vm
        yvGpL5/JX1/v7Ne35XLtvwVfhP3Pt0nfS2aZcZejcuLSSdnPivs/fRWvUeHY0NSsxFKckWio
        xVxUnAgA8IEjoBYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvO5PK74kgw1HJSzmHznHanH+/AZ2
        i1XfpzJbrF80hcWide8RdgdWj02rOtk8+v8aeHzeJBfAHMVlk5Kak1mWWqRvl8CV8WxNH3PB
        AoGKi793MTYwnuDtYuTkkBAwkbjcP4Gti5GLQ0hgN6PEhRvXWSES4hJrP1xhg7CFJVb+e84O
        UfSMUaL79S5mkASbgI7E+75vYEUiAlUSv24uZAexmQU8JM5PXMcE0bCXUWLa4VVgUzkF7CTu
        znoOZHNwCAskSex4lA0SZhFQlViz+DELiM0rYCmx9uQWdghbUOLkzCcsEDO1JXoftjLC2MsW
        vmaGOE5B4ufTZawQcXGJoz97mEHGiwg4Saw7ETyBUXgWkkmzkEyahWTSLCTdCxhZVjFKphYU
        56bnFhsWGOallusVJ+YWl+al6yXn525iBMeIluYOxu2rPugdYmTiYDzEKMHBrCTC++Egb5IQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTMdyGsJ4Jzx+
        ytaZ1bTnh9HHCsWGzadtVX7u2yLQdnzXBr8vk7R3fDh3RGAvq2FX44EvDBv3S/ge8RabmP6j
        NjVM06w046HYsaiwTj5Js09bVP9c+XP7xbEInZuaLlEv2p3f6/4/F+z6Z6fbzlDt+zGXZ9qk
        7ZRmDeNQdVMK+jyv5IXvnysXg8P0V/0WW7GamdP18ea4O9OTPJoaQgTfRtrk6h+fYdqyxsHg
        vq0Om5+zqHbfjWq33M81D/bkzFm5ecbn+OepzFsjPypeDvz+rStz+cJVZac36wes6+3gZDzW
        UZJv5Sn05GfBr3iBd9dsLXR0JrQVXEg1W8MoM2+a0F6zTJ8ezW21If5vNgT0KrEUZyQaajEX
        FScCAA1cOFsAAwAA
X-CMS-MailID: 20220217120929epcas5p15c7c581fd884f38cdf60054af8be7f99
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220217115220epcas5p4655af31ab39c62e8acb89ce1652aa1cf
References: <20220217113839.2311417-1-mkl@pengutronix.de>
        <CGME20220217115220epcas5p4655af31ab39c62e8acb89ce1652aa1cf@epcas5p4.samsung.com>
        <3fb21251-a4de-2300-d1c6-5b98dd3c36d1@kernel.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 17 February 2022 17:22
> To: Marc Kleine-Budde <mkl=40pengutronix.de>; linux-can=40vger.kernel.org=
;
> Chandrasekar Ramakrishnan <rcsekar=40samsung.com>
> Cc: Rob Herring <robh+dt=40kernel.org>; devicetree=40vger.kernel.org
> Subject: Re: =5BPATCH net-next=5D dt-binding: can: m_can: list Chandrasek=
ar
> Ramakrishnan as maintainer
>=20
> On 17/02/2022 12:38, Marc Kleine-Budde wrote:
> > Since Sriram Dash's email bounces, change the maintainer entry to
> > Chandrasekar Ramakrishnan. Chandrasekar Ramakrishnan is already listed
> > as a maintainer in the MAINTAINERS file.
> >
> > Cc: Chandrasekar Ramakrishnan <rcsekar=40samsung.com>
> > Signed-off-by: Marc Kleine-Budde <mkl=40pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml =7C 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > index 3bc1ed39a0a5..b7f9803c1c6d 100644
> > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > =40=40 -9,7 +9,7 =40=40 title: Bosch MCAN controller Bindings
> >  description: Bosch MCAN controller for CAN bus
> >
> >  maintainers:
> > -  - Sriram Dash <sriram.dash=40samsung.com>
> > +  - Chandrasekar Ramakrishnan <rcsekar=40samsung.com>
> >
>=20
> There was no activity from that email at all, so entry in Maintainers and=
 here
> will be half-dead... Since the change in maintainers in commit
> ba23dc6dcab5 (=22MAINTAINERS: Update MCAN MMIO device driver
> maintainer=22) , Chandrasekar did not provide any reviews/acks/commits.
>=20
> Dear Chandrasekar,
> Are you planning to perform maintainer activities on this driver?
>=20
> Best regards,
> Krzysztof


Dear Krzysztof,

I will take up the activity,  Will actively  work on reviewing the patches =
now on.

Thanks and Regards
Chandrasekar R=20


