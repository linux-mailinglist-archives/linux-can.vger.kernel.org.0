Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4EA6194E8
	for <lists+linux-can@lfdr.de>; Fri,  4 Nov 2022 11:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiKDK4i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Nov 2022 06:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiKDK42 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Nov 2022 06:56:28 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252472BB3E
        for <linux-can@vger.kernel.org>; Fri,  4 Nov 2022 03:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsDssLX/KyIjPwzDwh1gLavFEEPz4IcMBrH7l9JSGprjO0kjkDDU+Es2M53ArbQSw/BM8KeE8sjzP49nS+m2VeIB36Qb5d8yyeTJbi3v6CWj/xeikJ2vMFmaWZmtrthJLpRRT4V8qubv5sdRov5AqiicC9cij355Ay/7N3PXhg6L3M/BYyglHbcFRLx3Ps5eR5JIUY/3pDmoChOWM87cndcLn3X2JQcUJeU/extjC2+j82a6bzKQYjK7moGuDsHEvaz5KHfkWtIdvN6G42QUTCN10h34H831uWcJLorIaSQJi8VzCTiek9jn0iM2pnIYuTC0dUYIvikZQmFmmuDPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhBteEw3GBaLdj3z938y2p0JbF0VdsSdl4DBvc0+d6k=;
 b=h3ZaGfR/R4T9wuhwDJGN6x2AH4e+2zrpTUJuyndSjvFCnQb2SsfstVB2Tq4dw8nXoAd1JGXhL3I25FLM+vugvQNsnAU3yLZygPAJlAao7DP9T88+6BsBcLnUUl7jJMyvrz5y4BqaclWAjTmMw33TiMK4I1StpQs/UAYBm6YrboV++jtiNh43S0aM17BWyTj7dhv68HyIMGnrNz9O+iuTSwsLHfrZwznAPMLEiRGO1i5lax6jcz+xWfCZuuHt862bSvNr32IOH3OHam8RWwf+cDLlaRoFeC/Cidap/HK/qUeS+Akv2oYb9giUgaYsVaRvSH8LxpUXp+53MhbIBRfyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhBteEw3GBaLdj3z938y2p0JbF0VdsSdl4DBvc0+d6k=;
 b=jxF1UgIPUFzS5lw5NgAs/m2FNlicOku47oLGu7L5DBVWeTS/I64+f34X2L53vK4ywNCLVTnRMjNTRDz/1Fg653O7lfFrsz+ss6y9E7qY6M4pX3/76izhVZ4T8TL2yBM047Db8UZvfBbDotGMjdDd+cqZ8+GJtgkig8aD+8k+mKg=
Received: from DU2PR03MB8108.eurprd03.prod.outlook.com (2603:10a6:10:2f3::13)
 by GV2PR03MB8875.eurprd03.prod.outlook.com (2603:10a6:150:bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 10:56:16 +0000
Received: from DU2PR03MB8108.eurprd03.prod.outlook.com
 ([fe80::108b:e105:847d:a12b]) by DU2PR03MB8108.eurprd03.prod.outlook.com
 ([fe80::108b:e105:847d:a12b%4]) with mapi id 15.20.5791.020; Fri, 4 Nov 2022
 10:56:16 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: presume-ack option exact meaning
Thread-Topic: presume-ack option exact meaning
Thread-Index: AQHY8DsTKPcUtwi44Eu9H/7oHZe1tA==
Date:   Fri, 4 Nov 2022 10:56:16 +0000
Message-ID: <DU2PR03MB8108CC9551DF1818EE355542D63B9@DU2PR03MB8108.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR03MB8108:EE_|GV2PR03MB8875:EE_
x-ms-office365-filtering-correlation-id: ef340c9b-d2c3-41e0-7154-08dabe53327d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vC0aX+EiUO6FGxxp4S7Fej16FrJh2hKwMUdeu+KyjxUEW5PMzkJmrF3YLSKDRxh3fmnTfLvAOciXiBFhJIxfy5DUTFsiA88kdgHz+KcHVxmVKe5HBDAQU0cXZIeAq9qI2EIaeFXLD9NyIQ8qSyzk2jNhZ3twHdSUABt4SssXDtLnnPzImBVxR7XtJTkepI0B8WPXhppCeiYteS72i8lfLkYJe4SX62lXFJ6ZwH3UPUG304Sc1hYWsuY+mFzsYg5IvF7MVp1E/NEcNVkQ0R+xIQTLjLZr/ua+8bQNKGsj34zr2BsZK4oZcjQZljw888Yjg0ifsAGjCcv2YyjU6VmjxZ0RO+JKFcrF832XhfzJLuhJmqbN3Ar+mfavIpeFu4nzhsNUNq/Igr4sAPdzlGkuOrhRHGvaeH0slqCeCqmt3A4Daw+28uzrpzHbbr3j1/hPcPt7hQGnK2Tkaxc28l5B0FTI8yuv6lFagFbx5aztJpZncO1oIYdoV2wVqxTJC0L8U2lXbJ65s31PI04d6GCn58NtOI9h57FgXKmjvEreIh2uIZO+ZJpcRXcCEA7DNcQGH59Akp7gWFnWjHSRMYZASqXQDJ3k8ZEv1LHd7+m7sRZzrjDtX4gCPZObiy4ZI8c9WYn8Lk9uhlCay+Vt8nTdASifCLXNlxcNyb6YIn+r4Efdc+X7ymZTig5PES02k9NyCw6sdWmgpCDhnaA/UEsyS7tp8UQzseYKZk08fJxOyy61cEVtvPRCcOkSNjEEs34ksi/Y/GG3wjmGLKZwB2lJjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR03MB8108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(136003)(346002)(366004)(396003)(376002)(451199015)(55016003)(15974865002)(478600001)(71200400001)(66899015)(316002)(6916009)(9686003)(8676002)(76116006)(66446008)(66946007)(64756008)(66476007)(6506007)(91956017)(52536014)(26005)(66556008)(7696005)(8936002)(5660300002)(2906002)(4744005)(186003)(3480700007)(33656002)(41300700001)(86362001)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?irvDw4qixnzUch/nJl0SkrH1JrS7h+nHGOdyRwGErB32JasnfnaVgOW/h5?=
 =?iso-8859-1?Q?rKOU2AgPWSnyuYaSyH9ig9imj/EY/BcMA/VjwVFEN1K8WYsBbq+VFgGPmS?=
 =?iso-8859-1?Q?gLC6B9AO2mih9a9oy5TVvSBIjFE6JDytK4M8EzURX8oPDkCuNKA3MPRtBI?=
 =?iso-8859-1?Q?LSLfGYg3InqanHRam4nn2cU5QGgVqcnvkq1TT9gauTDP/FwJFPgD1ekNYN?=
 =?iso-8859-1?Q?4q0Nw4xQ+FWbh+7UmipIzjmcydnwmA9N0olb4FCEq2D3bqRRV7GxcFueQu?=
 =?iso-8859-1?Q?LCZjGOaNZatdu0mQn26wM6ZhYX/wi0rE6ma8aOqGaEN8BvR+AVK9T3Dgzo?=
 =?iso-8859-1?Q?XerTAL052i4dnJIS4nkUM+86678YC+EVW8V6TVLApRVT5KXs3m02Cct2sS?=
 =?iso-8859-1?Q?nCOkP4ZennG0sG9xhzWszYtoxoGCz1UWkhAts9OPEfqkGigEVThHUGrU6g?=
 =?iso-8859-1?Q?k7QfqmtveMbVuu5w3Nq6ZxNguM6h9f5NLyuhpd2/Ii/jVgnAsoclfol7rz?=
 =?iso-8859-1?Q?EaZLEkQo456QtcYwixOH3MGY8kyX+X9s6X0+0cEt4FR3inuXgQx4Usu8Vw?=
 =?iso-8859-1?Q?9LDgkEKeBQqNv09D4DcXLXsuHpiZx5bAWDr+HuzrJyloq0OheBnLr1OA6E?=
 =?iso-8859-1?Q?KpRocxjf0k4b9T/zLSkeNETDQ9BGg4CjZoTZlRg3VvUNkGRr16eE0XXUkw?=
 =?iso-8859-1?Q?Xm4eGeqKvQrZ1SuebxchZvK7EUXecLaLnIt0wOXXp6aKQjQ148bYuQQJOM?=
 =?iso-8859-1?Q?4MIyW/uIafC2U7VhfrmmZq868PvIdkPVBh22/r4ZbgKbCwSmVNMhvyhS93?=
 =?iso-8859-1?Q?JUG+hc38MPSzoZeo0uVkBisBjvONZrTHHAOSUrGWvFYsQVX+OSDwzP13nC?=
 =?iso-8859-1?Q?vANaq3gbvx64hgWCOolpX02pnOwUcYfyll/D5oK11ZaDEJ+sAAyb8VmJwP?=
 =?iso-8859-1?Q?dYj4NI6+L/jbw+oz5EfWBBeST6lgtDSAxxh0/id2vry/yDG39ILY/Y+Pnj?=
 =?iso-8859-1?Q?UGIFjjHu4t2eI3UzTCeO8uuGCrtbpqGEVVekYwCo3CIZ+1pnP7lCJiBkVX?=
 =?iso-8859-1?Q?Qm9Hct3l8NqrsZjOlKgrAhjTVmPG4Ce9jhzIr0lrF5WK3K4W00l7e9lHnU?=
 =?iso-8859-1?Q?zN14VXKsbYB1qhltvZl/a0rGAZs2yL9T8+d8tXXlzsgraLex460efioJaO?=
 =?iso-8859-1?Q?ov+qW6RqwBqNppoM5fzzNze0lBpfmkADKaT+Vuyq97LZeDCTKfnMBMMOnF?=
 =?iso-8859-1?Q?tus25OEcJlXdeXtq8R5CJFSz4OHTYWd1gjPr3qHfNhlCnYLHbjhyBqgXw8?=
 =?iso-8859-1?Q?qE4GNHRsSl3Bim652rnXP5OkYkw0cql8mH3nUAy3Wx7t6dvfjkIU5bkna9?=
 =?iso-8859-1?Q?Ms9g2LUSoRloGQ7mxkuHp0QgoD5ekRqymW9YbDbCq5dFekgIUcY2UtHbD1?=
 =?iso-8859-1?Q?Jew9DrdpFyZPBsBu50S/v5D9BvvsgGdqEbfFtHmyQCpjb9otrwuVOPOGr8?=
 =?iso-8859-1?Q?aQKil2ch3d8wgqVZa6W2u34MZyepvmzYrpiHmDgmN4g8yKXugrTdlk8ACe?=
 =?iso-8859-1?Q?5c99vHWketQsX/au9P8dE/Ia4yhg7Ir5/Bb5qsDCW2tXWWXMhXSX6uvVg9?=
 =?iso-8859-1?Q?E89rMYGedMVjqFXzt85skA0E4wuuLVEEbg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR03MB8108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef340c9b-d2c3-41e0-7154-08dabe53327d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 10:56:16.4522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OHW9fMJVPE8UrQt8AeqLrHxxYc5lseGzVC0YgHRwFH7/Jlr+eLCBXOYKDUI4VFSUjalSR7U+aY0yHxJ6J82nLqfdLeJCNS1OOwOh6HFYkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8875
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello all,

I have searched the net, but I can't find a clear explanation of what the "=
presume-ack" option available in socket-can is.

Some PEAK-System devices offer an option called "self-ack" which allows the=
 controller sending the frame to also send the ACK itself.

Does this behavior correspond to what the "presume-ack" option should enabl=
e?

Thank you all for your help and regards,

-- Stephane

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
