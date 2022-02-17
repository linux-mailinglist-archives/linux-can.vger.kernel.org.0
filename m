Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D394BA9D7
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 20:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiBQTcO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 14:32:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244447AbiBQTcN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 14:32:13 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3396169
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 11:31:57 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220217193154epoutp02f241b20048ad61b30537f7d4394385f6~Uqaq7k2I-1881618816epoutp02U
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 19:31:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220217193154epoutp02f241b20048ad61b30537f7d4394385f6~Uqaq7k2I-1881618816epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645126314;
        bh=Z19OJUtqKZGWENK4dRf57tJxrf0gndDRH8fZ3ojLAu8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NH/qf8b2AQjDv8W6AFtZyjcpdBH50jBzx4u8seoD3+j7vMfyQFFQ9NdYUnoRA5Sa/
         Gz+yCMIwB8cKwSdoAWDoLA1oPK1t3RSAWJmBB9frjb4XiEwrRJ2zAGpovW+nNcKoN3
         k8mtR3TI5WQLEC/9gOcvd1tkfr2ZJsteACR+AKWU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220217193153epcas5p4e02997a5958d15c243e76f5f6dea753d~UqaqQINdQ3205732057epcas5p4D;
        Thu, 17 Feb 2022 19:31:53 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4K04hN2VhDz4x9Pq; Thu, 17 Feb
        2022 19:31:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.FF.05590.4A2AE026; Fri, 18 Feb 2022 04:31:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220217155838epcas5p2900d5bed2012a3f8d41b525cab49f284~Ungdba8-_1208312083epcas5p2w;
        Thu, 17 Feb 2022 15:58:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220217155838epsmtrp20d4f82c11678ca2a0199ea4fe218eb80~UngdauRB50255602556epsmtrp2O;
        Thu, 17 Feb 2022 15:58:38 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-d8-620ea2a47935
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.54.08738.EA07E026; Fri, 18 Feb 2022 00:58:38 +0900 (KST)
Received: from rcsekar03 (unknown [107.122.12.252]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220217155837epsmtip27b1eff077c92275797fdc8ee18722ac0~Ungcf3T6e0877008770epsmtip2f;
        Thu, 17 Feb 2022 15:58:37 +0000 (GMT)
From:   "Chandrasekar R" <rcsekar@samsung.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "'Benjamin Gaignard'" <benjamin.gaignard@st.com>
In-Reply-To: <20220217101111.2291151-1-mkl@pengutronix.de>
Subject: RE: [PATCH net-next] dt-binding: can: m_can: fix indention of table
 in bosch,mram-cfg description
Date:   Thu, 17 Feb 2022 21:28:35 +0530
Message-ID: <006f01d82417$39d94e20$ad8bea60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQIj6421GG8Qx6WuvDjrLzC6VacTlQHECvfCq/IvjAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTS3fJIr4kg1Uf+Sz65j9htZh/5Byr
        xarvU5kt1i+awmLRuvcIuwOrx6ZVnWwe/X8NPJ7+2Mvs8XmTXABLVLZNRmpiSmqRQmpecn5K
        Zl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBaJYWyxJxSoFBAYnGxkr6dTVF+
        aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xu/ZG9kLbvJVvJjZyNrA
        +IW7i5GTQ0LARKJ3zUdWEFtIYDejRPs0zS5GLiD7E6PEpfuTWCCcz4wSC1+9Y4XpmHrkMxNE
        YhejxIzVZ6CqXjBKvJjzmAmkik1AR+J93ze2LkYODhEBb4nmP+ogYWaBKomvkz+zg9icAlYS
        k+Z0sIDYwgI5EuvWLWIGsVkEVCW2vvkEVsMrYClx9ttiZghbUOLkzCcsEHPkJba/ncMMcZCC
        xM+ny1gh4uISR3/2gMVFgOZ3TNvOBnKbhMBfdom/7TdYIBpcJL4faWaHsIUlXh3fAmVLSXx+
        txeqoZlRYu+Ra1ANExglup4oQNj2EgeuzGEBeYxZQFNi/S59iLCsxNRT65ggjuCT6P39hAki
        ziuxYx6MrSgxbetMsFYJoEOPzAuZwKg0C8lrs5C8NgvJO7MQli1gZFnFKJlaUJybnlpsWmCc
        l1oOj+/k/NxNjOBEqeW9g/HRgw96hxiZOBgPMUpwMCuJ8H44yJskxJuSWFmVWpQfX1Sak1p8
        iNEUGN4TmaVEk/OBqTqvJN7QxNLAxMzMzMTS2MxQSZz3VPqGRCGB9MSS1OzU1ILUIpg+Jg5O
        qQamxOMu6uwNs/6uOZm06y6LzLdJHq82v3XmFFCcmaEo/JG1+Fi20Z3L1exHbz2t4fx9r+l6
        Yn6+nMmlX7yvWdSWPnDQtpdZvSry5OyQog9VgXnse60XTXMMvbNbKMrf73Pm9iu2zsI7ju26
        XbWW91Wx9Y8VDut8D/1x87nvHumupFF/9FjnHoZTHNX9d277NF/ZlD/RLGPdv6ycWenVm9n3
        7nnU5mowberuKqWb586X5W6x/L6h/sUH6zoxX6fvvBJWFfdsjJfsfLfim/Vd3voj6myl7obL
        bVR6Dv+NYlh9aJvMUfu0yOUhW5Y8imx6/kj/QvZtIb+ZS2NVnVuW715tobxCbvL9LP4mm9NN
        grd3KLEUZyQaajEXFScCACU3OL8dBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO66Ar4kg6OveSz65j9htZh/5Byr
        xarvU5kt1i+awmLRuvcIuwOrx6ZVnWwe/X8NPJ7+2Mvs8XmTXABLFJdNSmpOZllqkb5dAlfG
        79kb2Qtu8lW8mNnI2sD4hbuLkZNDQsBEYuqRz0xdjFwcQgI7GCVOrl7HBpEQl1j74QqULSyx
        8t9zdoiiZ4wSHa9eMYIk2AR0JN73fQMrEhHwlTjf08MMYjML1EicOtPHCtHQzSjx4/0aFpAE
        p4CVxKQ5HWC2sECWxOm5U8FsFgFVia1vPrGD2LwClhJnvy1mhrAFJU7OfAJUwwE0VE+ibSMj
        xHx5ie1v5zBDHKcg8fPpMlaIuLjE0Z8QN4gAreqYtp1tAqPwLCSTZiFMmoVk0iwk3QsYWVYx
        SqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHi5bWDsY9qz7oHWJk4mA8xCjBwawkwvvh
        IG+SEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxXDB1U
        9ew5jt5n7S59eynA42rBv7UzmB1/vKxyaDpZYMCjUlvzl/XiNbZnZ768MD1yUbe3uI3r3gXu
        8955wZr5+x4+/xh13y6j7D+j5k7nFWxc726qPxf32/mof2/Pk8ffuEMXTzusHpt5bOo/n9v9
        C9lb1TJ2PP996+mNKRP7+bUqs68p6D8/Iia7ceGdM1WeM24U7A1I/vFZ1Up3acOSrV+aOO64
        61UvDZ9X1FkSICvyclqIn1nXlkTeuKnKU4//++R/4mWI77pdzzJ2bZzX37h/XnmiMzv39HO9
        X6reTpgVG2r9lGddSp60/oXn6bXKRepT7bs+L1SpfnVhQpYR+6d3gS0yJStmCefGHjusxFKc
        kWioxVxUnAgAWZEhLgUDAAA=
X-CMS-MailID: 20220217155838epcas5p2900d5bed2012a3f8d41b525cab49f284
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220217130613epcas5p148a75f63b455ad14decf075f1842114b
References: <CGME20220217130613epcas5p148a75f63b455ad14decf075f1842114b@epcas5p1.samsung.com>
        <20220217101111.2291151-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



> -----Original Message-----
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Sent: 17 February 2022 15:41
> To: linux-can@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>; devicetree@vger.kernel.org; Marc
> Kleine-Budde <mkl@pengutronix.de>; Sriram Dash
> <sriram.dash@samsung.com>; Benjamin Gaignard
> <benjamin.gaignard@st.com>
> Subject: [PATCH net-next] dt-binding: can: m_can: fix indention of table
in
> bosch,mram-cfg description
> 
> This patch fixes the indention of the table in the description of the
> bosch,mram-cfg property.
> 
> Cc: Sriram Dash <sriram.dash@samsung.com>
This id does not exists anymore.

> Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
Changes looks fine, 
Reviewed-by: Chandrasekar Ramakrishnan <rcsekar@samsung.com>

>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index 61f9e512c346..3bc1ed39a0a5 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -69,8 +69,8 @@ properties:
>        M_CAN includes the following elements according to user manual:
>        11-bit Filter	0-128 elements / 0-128 words
>        29-bit Filter	0-64 elements / 0-128 words
> -      Rx FIFO 0	0-64 elements / 0-1152 words
> -      Rx FIFO 1	0-64 elements / 0-1152 words
> +      Rx FIFO 0		0-64 elements / 0-1152 words
> +      Rx FIFO 1		0-64 elements / 0-1152 words
>        Rx Buffers	0-64 elements / 0-1152 words
>        Tx Event FIFO	0-32 elements / 0-64 words
>        Tx Buffers	0-32 elements / 0-576 words
> --
> 2.34.1
> 
> 


