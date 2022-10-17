Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DE1601259
	for <lists+linux-can@lfdr.de>; Mon, 17 Oct 2022 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiJQPDJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Oct 2022 11:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiJQPDD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Oct 2022 11:03:03 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on0616.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e19::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893AC237D2
        for <linux-can@vger.kernel.org>; Mon, 17 Oct 2022 08:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFLDameGw7pl1oP6uuz+IijqMIRuH3CFUSAsqcx8unRDHBwgw0qRmFRpYcw++kw4DNl6qkK+zk0jymNU0mJdn/mtoO8T9nMmfFbl6Vk0L0spFtujEQBqQMoDFkTM8p81na+PftV/TzPWYR9edu0tEyNxKptWHPYv8rWSJzIZa3XlwUvFMCuNJL27hGdHdFR3wcpvFJ3Z3jZMNk9jxVY/m5ECEhS9yAltC4YDaNv+lLJK01N9n/ChJzVzkw1ubpmikxjA//Cji16rfUW540OeW58EX4fPwwHx0tGspuE9gvpTcD28XvyBHGBqOY4tp2pJFEPwM0m0aMrBsjPq0x8m0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXnJ++e5KPGvZRl34S7wPpHRBmN8SJ516kPdkeflKf0=;
 b=Haefdq+6S3HSE4pzAi5vlgiZxMOQLKQdiMfyLlvi84/Bu3ZIgz9NZDDu/+z6bmvA977NFPbi2ITX9VJhdtIhSsK+/aCmBcx/hnuoPT0biJMSHy4+Vq/ZUpRNaXSarVA48WORakZ8b1RdvUDfy52u0wr3eVQ78ev2WhIPomJ8O7jTbGr3yQhJKCPsFz6UTXiZevafzigEQYD6D6KX+0DrrMuG/tvVieKKC0qqpmGtVRFsFKgG4yuUqtCjPmw2Uz6T9ERnu8+P1krUO1v2uoy+4bfI2SeyVgPuJ2G8AhA7gguj6wdfHO/R2EdjwFmkNThHfQyPx3FGL8O1pfDPQPL23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=actia.fr; dmarc=pass action=none header.from=actia.fr;
 dkim=pass header.d=actia.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=actia.fr; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXnJ++e5KPGvZRl34S7wPpHRBmN8SJ516kPdkeflKf0=;
 b=kg6hETt/PMm75yOeTw80MbJNpNWUlw0Rivm277jALBg0qLJ2sj4X5FgLXCCRuQOPlKUFiHQQnAoxqdLQg5LrF9WwoGMjlLTjWoFbwRDYTyjHTtq9bOzmmJ4IHFsY/jX+NHsJIGjl9eR24belI40s/NReJk7ZATKIwMleJHWrHIc=
Received: from PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e0::12)
 by PR0P264MB1579.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 14:55:58 +0000
Received: from PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM
 ([fe80::4cbd:493e:7d7f:22ce]) by PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM
 ([fe80::4cbd:493e:7d7f:22ce%2]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 14:55:58 +0000
From:   Sebastien FABRE <sebastien.fabre@actia.fr>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: J1939: Send messages without acknowledging
Thread-Topic: J1939: Send messages without acknowledging
Thread-Index: AdjiOArCihCCUJS2S0aV5OLbcs6cdQ==
Date:   Mon, 17 Oct 2022 14:55:58 +0000
Message-ID: <PR0P264MB23096FC238E648331A32B5A492299@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=actia.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR0P264MB2309:EE_|PR0P264MB1579:EE_
x-ms-office365-filtering-correlation-id: d97f241a-f849-4253-8689-08dab04fb333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3CeZWvNwr5Ie1iyqcUIujl1LmDz7DFK940nutDlPT/gKlXpKHrXkqH1YNWs2GngZjkXt4IQthGYRQucTmiej8JLpBR+QTrp8DnwQFQcC0mR/A+SsQeYrz44xfev4Y62JrjF1C4FtnBVfOQZ13dCuJ0AvXkPMZ/3lH82E6Ao0IKUfzXgK/MUQG035pZPkkAm9o1c0Q8WkldQgs/Hz3vIa4seyWXFK+hODstkIOsEa5ODE4E8k61XkDJJodhdXQsZkKLB1oAKtRtLeB+kJ9AO9B0mNktnvo7OfQDfk8ZNNRZYOZviZ09hSaQgqnzhH3hWbU28h823YiJ+vcL9R4/YwDAypoX02/sGjWQXHpYlDG4lwv4kZGUiIrf5prChr8jXDHCWT2zX6bFGDIVNmiKWIQT0QZ7RiCpGiO9TRycsgLVqQTS+3lwPAiSprZAnNNx/chStj22YhdkyT8LW+Rd0quIya1Tofb8qR0ifQupMqxi6bLn11p5v3sbrK4PrgrV4pA9NFD1VSFu4lJ8Fz9pBwJB5GWohz5vPmVVAiubzU2rjD6vZOrn9Lm1SbTz4lqSpyL1BRruiOK1Yzt4jmzRYXCn/ucap5AEahtHvVLg35QtjN2/eOI28uJH5S3BUHhdZTTl2GCCfpRkfNiodVUwgGgv593Q70WSCaw+PfcVniq5sRMaAV/sX9ANWa+NmOEUQ43GoRW61XZeyzVxe762V48yWl8i7cVVHj2RPskPL4JBc4PAmYirQ9Qzq+Cc0wc1JkAh9wIUm48JxApfCXFpC+hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(478600001)(33656002)(71200400001)(6506007)(41300700001)(8936002)(52536014)(316002)(8676002)(6916009)(76116006)(66556008)(64756008)(66946007)(66446008)(7696005)(122000001)(55016003)(66476007)(38100700002)(86362001)(186003)(38070700005)(9686003)(83380400001)(66574015)(26005)(2906002)(15650500001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E2NndSOYfiZ/4zJFS5SqJWaLBxVuG5W80Km1LW+qR56qQkbdu5pDXVSAqk?=
 =?iso-8859-1?Q?wvplVERz9KcQxImKe/ls2GtD2PtYxQ93LriQCCuxQtv2QagCFSKdpwiQSE?=
 =?iso-8859-1?Q?s2zpY4KVkJqJplFMRYh0ffqBoDfx2rt7gipo52L7rH/z/XbSanocj9TEwF?=
 =?iso-8859-1?Q?yFF/6eybE8eBRqEIZDv9QUGmpIWv1p4TY9otLe0Uh9niXy2VdPNHpEco3k?=
 =?iso-8859-1?Q?JNuMcTYoJlKhtZYjED2peHCuw8iHS50/KYY8ybaz+1pWR+PD/vDHb460rH?=
 =?iso-8859-1?Q?DcYyTwWKImWekz4kqPGQnfnaFk2cktShfRz4tTJqepYXhwHeFxGhlK2wwM?=
 =?iso-8859-1?Q?X+zRsXKSwuuGDoxFmVzhoDh2LM8JdQAPkvZyOTmmaRTxlKhygX9lgcy+Yu?=
 =?iso-8859-1?Q?h2rHOukWC+B8SnHt8T3cHaO7ajDJ3xPByOlIM7H2nzUtIshQzPFPrp8LtG?=
 =?iso-8859-1?Q?3BUauMfhKtQTawJWF2083Opeczeze0hTx0oJCR4fb77prGyNaXjVw1SJ6i?=
 =?iso-8859-1?Q?X/1TEA+0JJtKoFuwVlspTo5o1hopd5p69RccwIQfY26CaA9XMRtFMNuwVU?=
 =?iso-8859-1?Q?H7mn+kXcy9pZS0893VSf+oDYPELoBwChPfzfxQTNZe0Pl7XlY7lq6d3Gzj?=
 =?iso-8859-1?Q?VjpdwgCGBGwz+kp3eNhWGdaHyHP86v1YKFHXBHIl+6ow4aUb6xC5Q1c74j?=
 =?iso-8859-1?Q?NkusGD5bnQDv3TVa7GIug6jDvUYZJdZ/BuFD+bs7xsvO8bs+6JkvXDMOos?=
 =?iso-8859-1?Q?KbR8GEZdx2AlP3fhnpyNqAyU7iH7irX2k8sLr44I6x8UHoMNjJxRHVPhjk?=
 =?iso-8859-1?Q?qKU/lPZoRXAbyUrXirEKT0X9zWDeTOSPFyhUmaOfWaAwgJ5TXb9EHk/xGF?=
 =?iso-8859-1?Q?qMuQxRw4OcAHhYhg8qUfFkKvEe9wjvDojr7+4gYQnforUH3lw01CEkk4DY?=
 =?iso-8859-1?Q?O4B6sVjOg91kXlWJMBqTPpFnUmHj5XaHeO83gXIRfxVHo5VSK3mqn+lC0F?=
 =?iso-8859-1?Q?XQdg00j1NSnvysli3kPD609HOWVr8ArG6WwtgTDO4SX7Lr/sN/OJKJ39Fh?=
 =?iso-8859-1?Q?7y/WiuRMmHB6r9iqzCCLSS0Y+xP7X/5oBXnRrs9zzIql1d04E4g/OCidEh?=
 =?iso-8859-1?Q?ti1s4vGcNr2MpUkO8+DiiKqgssaTY2SZ0HhDcoZZaHP9Qdi79DJY3MiZSk?=
 =?iso-8859-1?Q?tq+EVcxOpB/nBi/toHU6d03g/fEGgyMFwJuT1rDJdpXkapYOfHZbsbeeRu?=
 =?iso-8859-1?Q?CQHRrNcsCguR8luhdUPEgfa+gGKFXo9+QVrDxy/3Ieu2kjYmaZL9+56f4f?=
 =?iso-8859-1?Q?oHt4GSFThlL6hOBz2JgEB+i+ZJ28jzuDbonUmeFE+YExKpYA9h+Beyd+eW?=
 =?iso-8859-1?Q?q2XYKUqKk4LEjlJcniUibZPKvU9458LxbGfXq3oY+v9eLGZ++wuJsK2HTw?=
 =?iso-8859-1?Q?ylA8vAwBFcqEmnpOOtAYZgEoqUtepoHS8j4avoYRxgcspt0XvRMa1BiKBN?=
 =?iso-8859-1?Q?7bozZwJJkTecz0S/hVCjJsaSfkpvaaUDYF2nVlI8TYEUDkF8MIKhaRolys?=
 =?iso-8859-1?Q?LlUJOpo7yvs93r+2dqfOL0r5remLE+9e5PhatZReag4StZTd4M72mqFYry?=
 =?iso-8859-1?Q?A62KMpt6LZswe4vX1q7JsGpKVokaew1y1J?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: actia.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d97f241a-f849-4253-8689-08dab04fb333
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 14:55:58.1437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86314f06-03e8-4460-82f3-a44f992a19c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xupfAGGJ7j6PMKpzMeuCfyqFXgbR2QrxLvcDVXYNRkjrjhSMg88w+I6OoytMMLn7af8sesdl03hINZJATOS9Z7aL1e3nfR6h8sYx0bE4sFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1579
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

I am working on 5.4 kernel, and I have the same behavior with 5.10 kernel v=
ersion.
I reproduce the behavior with a custom application. A j1939 socket is creat=
ed with SO_BROADCAST and SO_J1939_PROMISC options and is binded. The applic=
ation sends a claim message then 50 broadcast messages in loop (without wai=
ting) with size greater than 8 bytes (50).

Every sendto methods return success directly and sessions are stored in sk_=
session_queue.
If the can is 'on' but nobody acknowledges, after some times, trames are no=
 longer sent (ENOBUFS) but the application does not have this information (=
sendto returned success).
Moreover, txqueuelen does not have impact to this behavior (queue size seem=
s to be infinite).
To finish, closing socket will take a long time depending on sk_session_que=
ue size because of J1939_XTP_TX_RETRY_LIMIT: kernel seems to try to send ev=
ery message 100 times if ENOBUFS is received.

Is it the expected behavior? How can the application know that messages are=
 no longer sent?=20

Best regards,
S=E9bastien Fabre=20

